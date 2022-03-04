part of 'auth_cubits_cubit.dart';

enum LoginStatus { initial, loading, success, error, userLoaded }

class AuthLoginState extends Equatable {
  AuthLoginState({
    this.status = LoginStatus.initial,
    String? exception,
    String? userId,
    Massian? massian,
  })  : exception = exception ?? "",
        massian = massian ?? Massian.empty,
        userId = userId ?? '';

  final LoginStatus status;

  final String exception;

  final String userId;

  final Massian massian;

  @override
  List<Object> get props => [status, exception, userId];

  AuthLoginState copyWith(
      {LoginStatus? status,
      String? exception,
      String? userId,
      Massian? massian}) {
    return AuthLoginState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      userId: userId ?? this.userId,
      massian: massian ?? this.massian,
    );
  }
}
