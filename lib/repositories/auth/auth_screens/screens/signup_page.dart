import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mass_app/repositories/auth/auth_screens/screens/confirmation_page.dart';
import 'package:mass_app/repositories/auth/auth_screens/screens/login_page.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_repo.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_service.dart';
import 'package:mass_app/repositories/auth/blocs%20&%20cubits/cubit/auth_cubits_cubit.dart';

import 'package:mass_app/utilities/buttons/text_button.dart';

import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilities/auth_buttons.dart';
import '../utilities/auth_textfields.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    String _email = '';
    String _number = '';
    String _name = '';
    String _password = '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
          child: RepositoryProvider(
            create: (context) => AuthUserRepo(authService: AuthService()),
            child: BlocProvider(
                create: (context) => AuthLoginCubit(
                      authUserRepo: context.read<AuthUserRepo>(),
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthBackButton(),
                    const SizedBox(height: 8.0),
                    'Create An Account'.bigBold,
                    const SizedBox(height: 8.0),
                    'Fill the form below to get started'.authText,
                    const SizedBox(height: 8.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AuthTextField(
                              keyboardType: TextInputType.name,
                              label: 'Name',
                              onSubmitted: (a) => _name = a!),
                          AuthTextField(
                            keyboardType: TextInputType.emailAddress,
                            label: 'Email Address',
                            onSubmitted: (a) => _email = a!.trim(),
                          ),
                          AuthTextField(
                              keyboardType: TextInputType.phone,
                              hint: 'Phone Number (Optional)',
                              onSubmitted: (a) => _number = a!),
                          AuthPasswordField(
                            label: 'Password',
                            onSubmitted: (a) => _password = a!.trim(),
                          ),
                          AuthPasswordField(
                            label: 'Confirm Password',
                            onSubmitted: (pass) {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'By clicking "Submit", you agree to our \n',
                            style: GoogleFonts.montserrat(color: Colors.black),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _launchURL(1);
                                    },
                                  text: '\tTerms of Service ',
                                  style: GoogleFonts.montserrat(
                                    color: primaryColor,
                                  )),
                              const TextSpan(text: 'and '),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _launchURL(0);
                                    },
                                  text: 'Privacy Policy',
                                  style: GoogleFonts.montserrat(
                                    color: primaryColor,
                                  )),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    BlocConsumer<AuthLoginCubit, AuthLoginState>(
                      listener: (context, state) {
                        if (state.status == LoginStatus.error) {
                          var snackbar = SnackBar(
                            content: Text(state.exception),
                            backgroundColor: primaryColor,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else if (state.status == LoginStatus.success) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (c) =>
                                  ConfirmationPage(userId: state.userId),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state.status == LoginStatus.loading) {
                          return Center(child: loader);
                        } else if (state.status == LoginStatus.success) {
                          return Container();
                        }
                        return Center(
                          child: AuthButton(
                            text: 'SUBMIT',
                            onPressed: () {
                              _formKey.currentState!.save();
                              FocusScope.of(context).unfocus();
                              context.read<AuthLoginCubit>().signUpUser(
                                    username: _name,
                                    email: _email,
                                    password: _password,
                                    phoneNumber: _number,
                                  );
                            },
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Already have an account?'.authText,
                        MassTextButton(
                          text: 'Sign In',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                            );
                          },
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

_launchURL(int n) async {
  const _urls = [
    'https://www.masscitytour.com.ng/privacy',
    'https://www.masscitytour.com.ng/terms'
  ];

  if (await canLaunch(_urls[n])) {
    await launch(_urls[n], enableJavaScript: true);
  } else {
    throw 'Could not launch ${_urls[n]}';
  }
}
