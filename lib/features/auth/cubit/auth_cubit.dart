import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_exception.dart';
import '../data/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository(),
        super(const AuthState.unknown());

  final AuthRepository _authRepository;

  /// Checks for a previously stored token on app startup so the owner
  /// isn't asked to log in again on every launch.
  Future<void> checkStoredSession() async {
    final hasSession = await _authRepository.hasStoredSession();
    emit(hasSession ? const AuthState.loggedIn() : const AuthState.loggedOut());
  }

  Future<void> login({required String username, required String password}) async {
    emit(const AuthState.loading());
    try {
      final session = await _authRepository.login(
        username: username,
        password: password,
      );
      emit(AuthState.loggedIn(session: session));
    } on ApiException catch (e) {
      emit(AuthState.error(e.message));
    } catch (_) {
      emit(const AuthState.error('Could not reach the server. Check your connection.'));
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(const AuthState.loggedOut());
  }
}
