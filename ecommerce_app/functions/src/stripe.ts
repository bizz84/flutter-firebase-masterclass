import {firestore, https, Change, ParamsOf} from "firebase-functions/v2"
import * as admin from "firebase-admin"
import * as logger from "firebase-functions/logger"
import {updateImage, deleteImageFromStorage} from "./stripe_images"

const productPath = (id: string) => `products/${id}`

const cartPath = (uid: string) => `cart/${uid}`

const userOrdersPath = (uid: string) => `users/${uid}/orders`

const stripePricesPath = (id: string) => `stripe_products/${id}/prices`

const stripeCustomerUserLookupPath = (customerId: string) => `stripe_customer_user_lookup/${customerId}`

const latestOrderPath = (uid: string) => `latest_orders/${uid}`

/// Helper function to find the uid from the stripe customer ID
const lookupUserByCustomerId = async (firestore: FirebaseFirestore.Firestore, customerId: string) => {
  const docRef = firestore.doc(stripeCustomerUserLookupPath(customerId))
  const doc = await docRef.get()
  const data = doc.data()
  return data?.uid
}

/// Update product data at /products/$productId when Stripe products are added, updated, or removed
export async function onStripeProductWritten(
  event: firestore.FirestoreEvent<Change<firestore.DocumentSnapshot> | undefined, ParamsOf<string>>
) {
  const productId = event.params.id
  const firestore = admin.firestore()
  const doc = event.data?.after.data()
  if (doc === undefined) {
    // If the product was deleted from Stripe, delete it from the corresponding document in Firestore
    await firestore.doc(productPath(productId)).delete()
    // Delete the corresponding image from Firebase Storage
    await deleteImageFromStorage(productId)
    return
  }
  // If the product was added or updated, update the corresponding document in Firestore
  const {
    description,
    images,
    name,
    // eslint-disable-next-line camelcase
    stripe_metadata_availableQuantity,
  } = doc;
  // eslint-disable-next-line camelcase
  const availableQuantity = parseInt(stripe_metadata_availableQuantity)
  // Write the product data with the same ID to the `products` collection
  await firestore.doc(productPath(productId)).set({
    id: productId,
    title: name,
    description: description,
    // If the availableQuantity is not a number, set it to 0
    availableQuantity: isNaN(availableQuantity) ? 0 : availableQuantity,
  }, {merge: true})
  // Update the image if it has changed
  const imageUrl = images?.[0]
  const previousImageUrl = event.data?.before.data()?.images?.[0]
  const productDocRef = firestore.doc(productPath(productId))
  await updateImage(productId, productDocRef, imageUrl, previousImageUrl)
}

/// Write a price to /products/$productId when prices are added, updated, or removed.
export async function onStripePriceWritten(
  event: firestore.FirestoreEvent<Change<firestore.DocumentSnapshot> | undefined, ParamsOf<string>>
) {
  const productId = event.params.id
  const firestore = admin.firestore()
  // get a reference to the prices collection
  const pricesRef = firestore.collection(stripePricesPath(productId))
  const prices = await pricesRef.get()
  // For now, we only support the prices that are active, one_time and in USD
  const filteredPrices = prices.docs.map((priceDoc) => priceDoc.data())
    .filter((price) => price.active === true && price.type === "one_time" && price.currency === "usd")
  // Get the first price or return null if there are no prices
  const priceInUse = filteredPrices.length > 0 ? filteredPrices[0].unit_amount / 100 : null
  // write the price to the corresponding document in Firestore
  await firestore.doc(productPath(productId)).set(
    {price: priceInUse},
    // merge the data with the existing document to ensure the other fields are preserved
    {merge: true},
  )
}

/// write the Stripe customer ID to /users/$uid when a new stripe customer is created
export async function onStripeCustomerCreated(
  event: firestore.FirestoreEvent<firestore.QueryDocumentSnapshot | undefined, ParamsOf<string>>
) {
  if (event?.data === undefined) {
    return
  }
  const uid = event.params.id
  const doc = event.data.data()
  const stripeId = doc.stripeId
  const firestore = admin.firestore()
  try {
    // Create a document for reverse user lookup
    const stripeUserDocRef = firestore.doc(stripeCustomerUserLookupPath(stripeId))
    await stripeUserDocRef.set({
      uid: uid,
    })
  } catch (error) {
    throw new https.HttpsError(
      "aborted",
      `Failed to write Firestore data for email: ${doc.email}, error info: ${error}`
    )
  }
}

export async function onStripePaymentWritten(
  event: firestore.FirestoreEvent<Change<firestore.DocumentSnapshot> | undefined, ParamsOf<string>>
) {
  const doc = event?.data?.after.data()
  if (doc === undefined) {
    return
  }
  const status = doc.status
  if (status !== "succeeded") {
    // If the payment has not succeeded, don't do anything
    return
  }
  const paymentId = doc.id
  const customer = doc.customer
  const firestore = admin.firestore()
  // Do a reverse user lookup to get the uid from the stripe customer
  const uid = await lookupUserByCustomerId(firestore, customer)
  if (uid === undefined) {
    throw new https.HttpsError(
      "aborted",
      `uid not found at: ${stripeCustomerUserLookupPath(customer)}`
    )
  }
  // get the cart data
  const userCartDocRef = firestore.doc(cartPath(uid))
  const userCartDoc = await userCartDocRef.get()
  const userCartDocData = userCartDoc.data()
  if (userCartDocData === undefined) {
    throw new https.HttpsError(
      "aborted",
      `cart data not found at: ${userCartDocRef.path}`
    )
  }
  // check that the payment amount matches the cart total and print a warning if it doesn't
  const paymentAmount = doc.amount / 100
  const cartTotal = await calculateCartTotal(uid, firestore)
  if (paymentAmount !== cartTotal) {
    logger.warn(`paymentAmount: ${paymentAmount} does not match cartTotal: ${cartTotal}`)
  }
  const cartItems = userCartDocData.items
  // fulfill the order
  await fulfillOrder(firestore, uid, paymentId, cartTotal, cartItems)
}

export async function fulfillOrder(
  firestore: FirebaseFirestore.Firestore,
  uid: string,
  paymentId: string,
  cartTotal: number,
  cartItems: Record<string, number>,
) {
  // fulfill the order in a transaction
  await firestore.runTransaction(async (transaction) => {
    try {
      // save order document data so it can be read by the client
      const orderDate = new Date().toISOString()
      const orderData = {
        userId: uid,
        total: cartTotal,
        orderStatus: "confirmed",
        orderDate: orderDate,
        items: cartItems,
        productIds: Object.keys(cartItems),
        paymentId: paymentId,
      }
      const newOrderDocRef = firestore.collection(userOrdersPath(uid)).doc()
      transaction.set(newOrderDocRef, orderData)

      // delete all the cart items
      const cartDocRef = firestore.doc(cartPath(uid))
      transaction.delete(cartDocRef)

      // write the latest order ID
      const latestOrderDocRef = firestore.doc(latestOrderPath(uid))
      transaction.set(latestOrderDocRef, {orderId: newOrderDocRef.id})
    } catch (error) {
      logger.error(`Could not fullfill order for uid: ${uid}, paymentId: ${paymentId}`, error);
      throw error;
    }
  })
  // TODO: Update available quantities
}

/// Helper function to calculate the cart total
async function calculateCartTotal(uid: string, firestore: FirebaseFirestore.Firestore) {
  let total = 0;
  // iterate through all the cart items
  const cartDocRef = firestore.doc(cartPath(uid))
  const cartDoc = await cartDocRef.get()
  const data = cartDoc.data()
  if (data !== undefined) {
    const entries = Object.entries<number>(data.items)
    for (const entry of entries) {
      // extract the items data
      const [productId, quantity] = entry
      // find a matching product
      const product = await firestore.doc(productPath(productId)).get()
      const productData = product.data()
      if (productData !== undefined) {
        const { price } = productData
        total += price * quantity
      } else {
        logger.warn(`Could not find product with id: ${productId}`)
        throw new https.HttpsError(
          "aborted",
          `Could not find product with id: ${productId}`
        )
      }
    }
  }
  return total
}


