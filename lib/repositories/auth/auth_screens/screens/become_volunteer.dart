import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mass_app/repositories/auth/auth_screens/utilities/auth_buttons.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_repo.dart';
import 'package:mass_app/repositories/auth/blocs%20&%20cubits/cubit/auth_cubits_cubit.dart';
import 'package:mass_app/repositories/auth/model/auth_model.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/extensions/utility_strings.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

import '../../../home/screens/home_screen.dart';

class BecomeVolunteerScreen extends StatelessWidget {
  const BecomeVolunteerScreen({Key? key, required this.massian})
      : super(key: key);

  final Massian massian;

  @override
  Widget build(BuildContext context) {
    double _tHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: utilityAppBar(const Text(''), color: Colors.white),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'volunteer'.png,
              width: double.infinity,
              height: _tHeight * 0.4,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: 'About MASS Volunteers'.bigBold,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: UtilityStrings.volunteer.contentText,
            ),
            const SizedBox(height: 16),
            Center(
              child: massian.volunteer
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.check,
                            color: primaryColor, size: 24),
                        const SizedBox(width: 4),
                        'You\'re a MASS Volunteer!'.profileBold
                      ],
                    )
                  : BlocProvider(
                      create: (context) => AuthLoginCubit(
                          authUserRepo: context.read<AuthUserRepo>()),
                      child: BlocConsumer<AuthLoginCubit, AuthLoginState>(
                        listener: (context, state) {
                          if (state.status == LoginStatus.userLoaded) {
                            var snackbar = SnackBar(
                              content: 'You are now a MASS volunteer!'.obText,
                              backgroundColor: primaryColor,
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                            Future.delayed(
                              (const Duration(seconds: 2)),
                              () => Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(userId: state.massian.id),
                                ),
                                ModalRoute.withName('/Home'),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state.status == LoginStatus.loading) {
                            return loader;
                          } else if (state.status == LoginStatus.userLoaded) {
                            return Container();
                          }
                          return AuthButton(
                              text: 'Become a volunteer',
                              onPressed: () {
                                context
                                    .read<AuthLoginCubit>()
                                    .becomeVolunteer(massian.id);
                              });
                        },
                      ),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
