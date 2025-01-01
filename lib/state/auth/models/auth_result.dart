// enum AuthResult { aborted, success, failure }

enum AuthResult {
  // initial,
  aborted,
  success,
  failure('Something went wrong, please try again!'),
  unknown,
  loggedOut;
  // loading;

  const AuthResult([this.message = '']);

  final String message;
}
