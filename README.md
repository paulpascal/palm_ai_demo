# palm_ai_demo

A demo app to show how to use Firebase, Flutter, and the PaLM API to create a customizable chat bot using TDD Clean Architecture with BLoc.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [BLoc: Flutter Bloc State Managment ](https://bloclibrary.dev/#/flutterbloccoreconcepts/)
- [Cookbook: Flutter Testing  ](https://docs.flutter.dev/cookbook/testing/unit/introduction)

# Get Started

1. Clone this repo into your local directory
2. [Setup Firebase project](https://firebase.google.com/docs/flutter/setup)
3. In the Firebase console, enable Cloud Firestore
4. Install the [Chatbot with PaLM API extension](https://extensions.dev/extensions/googlecloud/firestore-palm-chatbot)
5. Install dependencies `flutter pub get`

✨ Enjoy!

# Test

In a TDD approach, when testing a class we need to figure out the answer to theses 3 questions:
1. What does the class depend on
2. How can we create a fake version of the dependency (dependencies)
3. How do we control what the deps is (are) doing?

In a TDD process, we should consider three main stages:
1. Arrange
2. Act
3. Assert

In a TDD approach, we should CODE AGAINST THE TEST (RED)