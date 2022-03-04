import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_repo.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  AuthStatusBloc({AuthUserRepo? authRepo})
      : _authUserRepo = authRepo!,
        super(const AuthStatusState()) {
    on<LoggedIn>(_mapLoggedInToState);
    on<LoggedOut>(_mapLoggedOutToState);
  }

  final AuthUserRepo _authUserRepo;

  FutureOr<void> _mapLoggedInToState(
      LoggedIn event, Emitter<AuthStatusState> emit) async {
    emit(state.copy(authStatus: MassianAuthStatus.initial));

    String? _userId = await _authUserRepo.getUserId();
    try {
      await Future.delayed(const Duration(seconds: 4));
      if (_userId != null) {
        emit(state.copy(
            authStatus: MassianAuthStatus.loggedIn, userId: _userId));
      } else {
        emit(state.copy(authStatus: MassianAuthStatus.logOut));
      }
    } catch (_) {
      emit(state.copy(authStatus: MassianAuthStatus.logOut));
    }
  }

  FutureOr<void> _mapLoggedOutToState(
      LoggedOut event, Emitter<AuthStatusState> emit) {
    _authUserRepo.logOut();

    emit(state.copy(authStatus: MassianAuthStatus.logOut, userId: ''));
  }
}
