part of 'auth_status_bloc.dart';

enum MassianAuthStatus { initial, loggedIn, logOut }

class AuthStatusState extends Equatable {
  const AuthStatusState(
      {this.authStatus = MassianAuthStatus.initial, String? userId})
      : userId = userId ?? '';

  final MassianAuthStatus authStatus;
  final String userId;

  @override
  List<Object> get props => [authStatus, userId];

  AuthStatusState copy({MassianAuthStatus? authStatus, String? userId}) {
    return AuthStatusState(
      authStatus: authStatus ?? this.authStatus,
      userId: userId ?? this.userId,
    );
  }
}
