import 'package:flutter/foundation.dart';

@immutable
class Strings {
  static const appName = 'CredBud';
  static const welcomeTo = 'Welcome to';

  // welcome page strings
  static const letsGetStarted = 'Let\'s get started! 👋';
  static const byContinuing = "By continuing, you agree to CredBud's ";
  static const termsOfService = 'Terms of Service';
  static const and = ' and ';
  static const privacyPolicy = 'Privacy Policy';
  static const termsOfServiceUrl =
      'https://github.com/CredBud/termsofservice/blob/main/README.md';
  static const privacyPolicyUrl =
      'https://github.com/CredBud/privacypolicy/blob/main/README.md';

  static const continueButton = 'Continue';
  static const loading = 'loading...';
  static const fullStop = '.';

  // login screen
  static const login = 'Login';
  static const activateAccount = 'Activate Account';
  static const hookLine = 'Ready to jump in? Login and go. 🙌';
  static const snackBarResetPassword = 'Please check your email!';

  // attendance mark screen
  static const scanToMarkAttendance = 'Scan to mark your attendance!';

  const Strings._();
}
