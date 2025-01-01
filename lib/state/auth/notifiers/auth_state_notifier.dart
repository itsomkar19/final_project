import 'package:credbud/state/auth/backend/authenticator.dart';
import 'package:credbud/state/auth/models/auth_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: _authenticator.userId);
    }
  }

  void updateAuthState(AuthState newState) {
    state = newState;
  }

  Future<void> logOut() async {
    state = state.copyWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.loggedOut();
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    state = state.copyWithIsLoading(true);
    final result =
        await _authenticator.signInWithEmail(email: email, password: password);
    final userId = _authenticator.userId;
    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> resetPassword({required String email}) async {
    _authenticator.resetPassword(email: email);
  }
}
