part of 'auth_status_bloc.dart';

abstract class AuthStatusEvent extends Equatable {
  const AuthStatusEvent();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthStatusEvent {}

class LoggedOut extends AuthStatusEvent {}
