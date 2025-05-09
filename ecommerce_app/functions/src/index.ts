import * as admin from "firebase-admin"
import * as functionsV1 from "firebase-functions/v1"
import * as functionsV2 from "firebase-functions/v2"

admin.initializeApp()

// Admin
import { makeAdminIfWhitelisted } from "./admin"

exports.onUserCreated = functionsV1.auth.user().onCreate((user, _) => makeAdminIfWhitelisted(user))

import { stripeSecretKey } from "./stripe_secret"
// Stripe triggers
import {
  onStripeProductWritten,
  onStripePriceWritten,
  onStripeCustomerCreated,
  onStripePaymentWritten,
} from "./stripe"

// Triggered when a Stripe product is written to Firestore
exports.onStripeProductWritten = functionsV2.firestore.onDocumentWritten(
  "/stripe_products/{id}",
  onStripeProductWritten,
)

// Triggered when a Stripe price is written to Firestore
exports.onStripePriceWritten = functionsV2.firestore.onDocumentWritten(
  "/stripe_products/{id}/prices/{priceId}",
  onStripePriceWritten,
)

// Triggered when a Stripe customer is created
exports.onStripeCustomerCreated = functionsV2.firestore.onDocumentCreated(
  "/stripe_customers/{id}",
  onStripeCustomerCreated,
)

exports.onStripePaymentWritten = functionsV2.firestore.onDocumentWritten(
  {
    document: "/stripe_customers/{stripeId}/payments/{paymentId}",
    secrets: [stripeSecretKey],
  },
  onStripePaymentWritten,
)

// Ratings
import { updateRating } from "./ratings"

exports.onProductReviewWritten = functionsV2.firestore.onDocumentWritten(
  "products/{id}/reviews/{uid}",
  updateRating,
)
