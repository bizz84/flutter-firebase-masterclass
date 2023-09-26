import {https} from "firebase-functions/v2"
import Stripe from "stripe"

import {defineSecret} from "firebase-functions/params"

// * Define a secret to store the Stripe Secret Key
// * To set it, run:
// * firebase functions:secrets:set STRIPE_SECRET_KEY
// * For more info, read:
// * https://codewithandrea.com/articles/api-keys-2ndgen-cloud-functions-firebase/
export const stripeSecretKey = defineSecret("STRIPE_SECRET_KEY")

/// Helper function to get the Stripe client
export function getStripe() {
  const secretKey = stripeSecretKey.value()
  if (secretKey.length === 0) {
    throw new https.HttpsError("aborted", "Stripe Secret Key is not set")
  }

  // https://stripe.com/docs/api/versioning
  const stripeApiVersion = "2023-08-16"
  return new Stripe(secretKey, {
    apiVersion: stripeApiVersion,
    typescript: true,
  })
}
