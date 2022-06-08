import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_app/repositories/auth/auth_screens/screens/forget_password.dart';
import 'package:mass_app/repositories/auth/auth_screens/screens/signup_page.dart';
import 'package:mass_app/repositories/auth/auth_screens/utilities/auth_textfields.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_repo.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_service.dart';
import 'package:mass_app/repositories/auth/blocs%20&%20cubits/cubit/auth_cubits_cubit.dart';

import 'package:mass_app/repositories/home/screens/home_screen.dart';

import 'package:mass_app/utilities/buttons/text_button.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';

import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

import '../utilities/auth_buttons.dart';

final _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _email = '';
    String _password = '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: RepositoryProvider(
          create: (context) => AuthUserRepo(authService: AuthService()),
          child: BlocProvider(
            create: (context) => AuthLoginCubit(
              authUserRepo: context.read<AuthUserRepo>(),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: AuthBackButton(),
                    ),
                    Center(
                      child: Image.asset(
                        'mass_iconn'.png,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    'Welcome back!'.bigLogin,
                    const SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AuthTextField(
                            keyboardType: TextInputType.text,
                            label: 'Email Address:',
                            onSubmitted: (p0) {
                              _email = p0!.trim();
                            },
                          ),
                          AuthPasswordField(
                            label: 'Password:',
                            onSubmitted: (v) {
                              _password = v!.trim();
                            },
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: MassTextButton(
                        text: 'Forget Password?',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const ForgetPasswordScreen()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Center(
                      child: BlocConsumer<AuthLoginCubit, AuthLoginState>(
                          listener: (context, state) {
                        if (state.status == LoginStatus.error) {
                          var snackbar = SnackBar(
                            content: Text(state.exception),
                            backgroundColor: primaryColor,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else if (state.status == LoginStatus.success) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(userId: state.userId),
                            ),
                            ModalRoute.withName('/Home'),
                          );
                        }
                      }, builder: (context, state) {
                        if (state.status == LoginStatus.loading) {
                          return Center(child: loader);
                        } else if (state.status == LoginStatus.success) {
                          return Container();
                        }
                        return AuthButton(
                          text: 'SIGN IN',
                          onPressed: () {
                            _formKey.currentState!.save();
                            FocusScope.of(context).unfocus();
                            context
                                .read<AuthLoginCubit>()
                                .loginUser(_email, _password);
                          },
                        );
                      }),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Don\'t have an account yet?'.authText,
                        MassTextButton(
                            text: 'Sign Up',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const SignUpScreen(),
                                ),
                              );
                            })
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
