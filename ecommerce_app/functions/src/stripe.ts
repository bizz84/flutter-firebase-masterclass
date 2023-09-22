import {firestore, https, Change, ParamsOf} from "firebase-functions/v2"
import * as admin from "firebase-admin"
import {updateImage, deleteImageFromStorage} from "./stripe_images"

const productPath = (id: string) => `products/${id}`

const stripePricesPath = (id: string) => `stripe_products/${id}/prices`

const stripeCustomerUserLookupPath = (customerId: string) => `stripe_customer_user_lookup/${customerId}`

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
