import 'package:mass_app/repositories/auth/auth_service/auth_service.dart';
import 'package:mass_app/repositories/auth/model/auth_model.dart';

class AuthUserRepo {
  final AuthService authService;

  AuthUserRepo({required this.authService});

  Future<String> signIn(String email, String password) async =>
      await authService.signInUser(email, password);

  Future<String> registerUser(String email, String password, String username,
          String phoneNumber) async =>
      await authService.registerUser(email, password, username, phoneNumber);

  Future<Massian> getUser(String userId) async =>
      await authService.getUserDetails(userId);

  Future<String?> getUserId() async => await authService.getUserId();

  Future<void> logOut() async {
    await authService.signOut();
  }

  Future<void> updateMassian(String userId, Massian massian) async =>
      await authService.updateMassian(userId, massian);

  Future<Massian> beVol(String userId) async =>
      await authService.becomeV(userId);
  Future<Massian> beDisc(String userId) async =>
      await authService.becomeDisc(userId);

  Future<void> resetPass(String email) async =>
      await authService.resetPassword(email);
}
