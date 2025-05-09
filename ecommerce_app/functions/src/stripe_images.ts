import * as admin from "firebase-admin"
import * as logger from "firebase-functions/logger"
import { v4 as uuidv4 } from "uuid"

// If the image has changed, upload it to Firebase Storage and update the product document
// If it has been deleted, delete it from Firebase Storage and update the product document
export async function updateImage(
  productId: string,
  productDocRef: FirebaseFirestore.DocumentReference<FirebaseFirestore.DocumentData>,
  imageUrl: string | undefined,
  previousImageUrl: string | undefined,
) {
  if (imageUrl !== undefined) {
    if (imageUrl !== previousImageUrl) {
      // If the image has changed, upload it to Firebase Storage
      const storageImageUrl = await uploadImageToStorage(productId, imageUrl)
      // And update the product document
      await productDocRef.set({
        imageUrl: storageImageUrl,
      }, {merge: true})
    }
  } else {
    // If the image has been removed, delete it from Firebase Storage
    if (previousImageUrl !== undefined) {
      await deleteImageFromStorage(productId)
      // And update the product document
      await productDocRef.set({
        imageUrl: null,
      }, {merge: true})
    }
  }
}

// * Due to CORS restrictions, the Flutter web client cannot load the images directly from Stripe
// * To work around that, we can use this function to download an image and upload it to Firebase Storage
export async function uploadImageToStorage(id: string, imageUrl: string) {
  logger.log(`Uploading image for product: ${id}, imageUrl: ${imageUrl}`)
  // This function was generated with the help of GPT-4. Full chat here:
  // https://cloud.typingmind.com/share/91d3fa49-1eff-4f5a-984f-7f4ba8dfb4e5
  const response = await fetch(imageUrl)
  const arrayBuffer = await response.arrayBuffer()
  const buffer = Buffer.from(arrayBuffer)

  const bucket = admin.storage().bucket()
  const file = bucket.file(`products/${id}.jpg`)

  const uuid = uuidv4();
  await file.save(buffer, {
    public: true,
    metadata: {
      firebaseStorageDownloadTokens: uuid,
    },
  })
  // the image will be publicly accessible at the URL returned by this function
  return `https://firebasestorage.googleapis.com/v0/b/${bucket.name}/o/products%2F${id}.jpg?alt=media&token=${uuid}`;
}

export async function deleteImageFromStorage(id: string) {
  logger.log(`Deleting image for product: ${id}`)
  const bucket = admin.storage().bucket()
  const file = bucket.file(`products/${id}.jpg`)
  const exists = await file.exists()
  if (exists) {
    await file.delete()
  }
}
