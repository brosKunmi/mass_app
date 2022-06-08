import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_repo.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_service.dart';
import 'package:mass_app/repositories/auth/blocs%20&%20cubits/cubit/auth_cubits_cubit.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

import '../../../../utilities/widgets/utility_widgets.dart';
import '../utilities/auth_buttons.dart';
import '../utilities/auth_textfields.dart';

final _formKey = GlobalKey<FormState>();

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    String _email = '';

    return RepositoryProvider(
      create: (context) => AuthUserRepo(authService: AuthService()),
      child: BlocProvider(
        create: (context) => AuthLoginCubit(
          authUserRepo: context.read<AuthUserRepo>(),
        ),
        child: Scaffold(
          body: Center(
            child: Container(
              height: _size.height * 0.4,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                boxShadow: kElevationToShadow[12],
                borderRadius: buttonBR,
                color: Colors.white,
              ),
              child: BlocConsumer<AuthLoginCubit, AuthLoginState>(
                listener: ((context, state) {
                  if (state.status == LoginStatus.error) {
                    var snackbar = SnackBar(
                      content: Text(state.exception),
                      backgroundColor: primaryColor,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  } else if (state.status == LoginStatus.success) {
                    var snackbar = SnackBar(
                      elevation: 12,
                      content:
                          'A password reset link has been sent to your email. Please follow the instructions to reset your password'
                              .obText,
                      backgroundColor: primaryColor,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    Future.delayed(const Duration(seconds: 8), () {
                      Navigator.of(context).pop();
                    });
                  }
                }),
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      'Please enter your email address'.profText,
                      Form(
                        key: _formKey,
                        child: AuthTextField(
                          keyboardType: TextInputType.text,
                          label: 'Email Address:',
                          onSubmitted: (p0) {
                            _email = p0!.trim();
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      state.status == LoginStatus.loading
                          ? loader
                          : AuthButton(
                              text: 'Reset Passowrd',
                              onPressed: () {
                                _formKey.currentState!.save();

                                context
                                    .read<AuthLoginCubit>()
                                    .resetPass(_email);
                              },
                            ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
