import 'package:credbud/state/auth/models/auth_result.dart';
import 'package:credbud/typedefs/user_id.dart';
import 'package:flutter/foundation.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;

  const AuthState(
      {required this.result, required this.isLoading, required this.userId});

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  const AuthState.loggedOut()
      : result = AuthResult.loggedOut,
        isLoading = false,
        userId = null;

  AuthState copyWithIsLoading(bool isLoading) =>
      AuthState(result: result, isLoading: isLoading, userId: userId);

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(result, isLoading, userId);
}
