# Flutter & Firebase eCommerce App

This is the official repo for this course:

- [Flutter & Firebase Masterclass](https://codewithandrea.com/courses/flutter-firebase-masterclass/)

This will include a full-stack eCommerce app using Flutter & Firebase:

![eCommerce App Preview](/.github/images/ecommerce-app-preview.png)

## Project Setup

At the beginning of each section (and other points in the course), I'll share an updated starter project with all the latest code.

Each starter project can be checked out from a **specific branch name**, as instructed in the relevant lessons:

```
git clone https://github.com/bizz84/flutter-firebase-masterclass.git
cd flutter-firebase-masterclass
git checkout <branch-name>
```

### Firebase Setup

Since the project uses Firebase, some additional files will be needed:

```
lib/firebase_options.dart
ios/Runner/GoogleService-Info.plist
ios/firebase_app_id_file.json
macos/Runner/GoogleService-Info.plist
macos/firebase_app_id_file.json
android/app/google-services.json
```

These files have been added to `.gitignore`, so you need to run this command to generate them with the flutterfire CLI:

```
cd ecommerce_app
flutterfire configure
```

### [LICENSE: MIT](../LICENSE.md)