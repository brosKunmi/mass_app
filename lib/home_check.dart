import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_app/repositories/auth/blocs%20&%20cubits/bloc/auth_status_bloc.dart';
import 'package:mass_app/repositories/home/screens/home_screen.dart';
import 'package:mass_app/screens/onboarding.dart';
import 'package:mass_app/screens/splash_screen.dart';

class HomeCheck extends StatelessWidget {
  const HomeCheck({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthStatusBloc, AuthStatusState>(
      builder: (context, state) {
        if (state.authStatus == MassianAuthStatus.logOut) {
          return const OnboardingScreen();
        } else if (state.authStatus == MassianAuthStatus.loggedIn) {
          return HomeScreen(userId: state.userId);
        }
        return const SplashScreen();
      },
    );
  }
}
