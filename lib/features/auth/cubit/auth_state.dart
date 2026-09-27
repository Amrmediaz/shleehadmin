import 'package:equatable/equatable.dart';

import '../data/owner_session.dart';

enum AuthStatus { unknown, loggedOut, loading, loggedIn, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final OwnerSession? session;
  final String? errorMessage;

  const AuthState._({
    required this.status,
    this.session,
    this.errorMessage,
  });

  const AuthState.unknown() : this._(status: AuthStatus.unknown);

  const AuthState.loggedOut() : this._(status: AuthStatus.loggedOut);

  const AuthState.loading() : this._(status: AuthStatus.loading);

  /// [session] is only available right after a fresh login call. When the
  /// app restores a session from storage on startup we only have the raw
  /// token (see [SessionStorage]), so [session] will be null even though
  /// the owner is logged in.
  const AuthState.loggedIn({OwnerSession? session})
      : this._(status: AuthStatus.loggedIn, session: session);

  const AuthState.error(String message)
      : this._(status: AuthStatus.error, errorMessage: message);

  bool get isLoading => status == AuthStatus.loading;

  @override
  List<Object?> get props => [status, session?.token, errorMessage];
}
