let isInitialized = false

export const lazyAdminInitializeApp = async () => {
  if (!isInitialized) {
    const admin = await import("firebase-admin")
    if (!admin.apps.length) {
      admin.initializeApp()
    }
    isInitialized = true
  }
}
