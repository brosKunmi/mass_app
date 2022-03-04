import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mass_app/home_check.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_repo.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_service.dart';
import 'package:mass_app/repositories/auth/blocs%20&%20cubits/bloc/auth_status_bloc.dart';
import 'package:mass_app/repositories/home/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthUserRepo(authService: AuthService()),
      child: BlocProvider(
        create: (context) =>
            AuthStatusBloc(authRepo: context.read<AuthUserRepo>())
              ..add(LoggedIn()),
        child: MaterialApp(
          title: 'MASS Movement',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xff1B1869),
          ),
          home: const HomeCheck(),
          routes: {
            '/Home': (ctx) => const HomeScreen(userId: ''),
          },
        ),
      ),
    );
  }
}
