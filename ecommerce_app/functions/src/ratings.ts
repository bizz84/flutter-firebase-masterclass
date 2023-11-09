import {firestore, Change, ParamsOf} from "firebase-functions/v2"
import * as admin from "firebase-admin"

export async function updateRating(
  event: firestore.FirestoreEvent<Change<firestore.DocumentSnapshot> | undefined, ParamsOf<string>>
) {
  const productId = event.params.id
  const firestore = admin.firestore()
  // get a reference to the reviews collection
  const productReviewsRef = firestore.collection(`products/${productId}/reviews`)
  // calculate the updated ratings
  const docRefs = await productReviewsRef.listDocuments()
  const numRatings = docRefs.length
  let total = 0
  for (const docRef of docRefs) {
    const snapshot = await docRef.get()
    const data = snapshot.data()
    if (data !== undefined) {
      total += data.rating
    }
  }
  const avgRating = numRatings > 0 ? (total / numRatings) : 0

  // update the product document in firestore
  const productRef = firestore.doc(`products/${productId}`)
  await productRef.update({
    avgRating: avgRating,
    numRatings: numRatings,
  })
}
