import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_repo.dart';
import 'package:mass_app/repositories/auth/model/auth_model.dart';

part 'auth_cubits_state.dart';

class AuthLoginCubit extends Cubit<AuthLoginState> {
  AuthLoginCubit({required AuthUserRepo authUserRepo})
      : _authUserRepo = authUserRepo,
        super(AuthLoginState());

  final AuthUserRepo _authUserRepo;

  void loginUser(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2), () async {
        var _uId = await _authUserRepo.signIn(email, password);
        emit(state.copyWith(status: LoginStatus.success, userId: _uId));
      });
    } on FirebaseException catch (e) {
      emit(state.copyWith(
          status: LoginStatus.error, exception: e.message.toString()));
    }
  }

  void signUpUser(
      {required String username,
      required String email,
      required String password,
      String? phoneNumber}) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2), () async {
        var _uId = await _authUserRepo.registerUser(
            email, password, username, phoneNumber ?? '');
        emit(state.copyWith(status: LoginStatus.success, userId: _uId));
      });
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
            status: LoginStatus.error, exception: e.message.toString()),
      );
    }
  }

  FutureOr<void> getUser(String userId) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2), () async {
        var _massian = await _authUserRepo.getUser(userId);
        emit(state.copyWith(status: LoginStatus.userLoaded, massian: _massian));
      });
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
            status: LoginStatus.error, exception: e.message.toString()),
      );
    }
  }

  void updateMassian(Massian massian, String userId) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2), () async {
        await _authUserRepo.updateMassian(userId, massian);
        emit(state.copyWith(status: LoginStatus.userLoaded, massian: massian));
      });
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
            status: LoginStatus.error, exception: e.message.toString()),
      );
    }
  }

  void becomeVolunteer(String userId) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2), () async {
        var massian = await _authUserRepo.beVol(userId);
        emit(state.copyWith(status: LoginStatus.userLoaded, massian: massian));
      });
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
            status: LoginStatus.error, exception: e.message.toString()),
      );
    }
  }

  void becomeDisc(String userId) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2), () async {
        var massian = await _authUserRepo.beDisc(userId);
        emit(state.copyWith(status: LoginStatus.userLoaded, massian: massian));
      });
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
            status: LoginStatus.error, exception: e.message.toString()),
      );
    }
  }

  void becomeMember(String userId) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2), () async {
        var massian = await _authUserRepo.beMem(userId);
        emit(state.copyWith(status: LoginStatus.userLoaded, massian: massian));
      });
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
            status: LoginStatus.error, exception: e.message.toString()),
      );
    }
  }

  void resetPass(String email) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2), () async {
        await _authUserRepo.resetPass(email);
        emit(state.copyWith(status: LoginStatus.success));
      });
    } on FirebaseException catch (e) {
      emit(
        state.copyWith(
            status: LoginStatus.error, exception: e.message.toString()),
      );
    }
  }
}
