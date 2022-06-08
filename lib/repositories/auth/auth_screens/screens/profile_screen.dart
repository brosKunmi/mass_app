import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mass_app/repositories/ads/widgets/home_ad_box.dart';
import 'package:mass_app/repositories/auth/auth_screens/screens/become_member.dart';
import 'package:mass_app/repositories/auth/auth_screens/screens/edit_profile_screen.dart';
import 'package:mass_app/repositories/auth/auth_screens/screens/become_disciple.dart';
import 'package:mass_app/repositories/auth/auth_screens/screens/become_volunteer.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_service.dart';
import 'package:mass_app/repositories/auth/blocs%20&%20cubits/bloc/auth_status_bloc.dart';
import 'package:mass_app/repositories/auth/blocs%20&%20cubits/cubit/auth_cubits_cubit.dart';
import 'package:mass_app/repositories/home/screens/drawer_screens/support_us.dart';
import 'package:mass_app/utilities/buttons/text_button.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

import '../../auth_service/auth_repo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return BlocBuilder<AuthLoginCubit, AuthLoginState>(
      builder: (context, state) {
        if (state.status == LoginStatus.loading) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitThreeInOut(
                  color: primaryColor,
                  size: 32,
                ),
                const SizedBox(width: 8),
                'Loading profile'.profText,
                SpinKitThreeInOut(
                  color: primaryColor,
                  size: 32,
                ),
              ],
            ),
          );
        } else if (state.status == LoginStatus.userLoaded) {
          var _massian = state.massian;
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: ExtendedNetworkImageProvider(
                      _massian.image,
                      cache: true,
                    ),
                    radius: _size.width * 0.2,
                  ),
                ),
                const SizedBox(height: 12),
                _massian.name.profileBold,
                _massian.email.profText,
                const SizedBox(height: 12),
                const Divider(
                  thickness: 0.8,
                ),
                ProfileTextButtons(
                  faIcon: FontAwesomeIcons.user,
                  title: 'My Account Settings',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditProfileScreen(
                          massian: _massian,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(
                  thickness: 0.8,
                ),
                ProfileTextButtons(
                  faIcon: FontAwesomeIcons.handsHelping,
                  title: 'Become a Volunteer',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BecomeVolunteerScreen(
                          massian: _massian,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(
                  thickness: 0.8,
                ),
                ProfileTextButtons(
                    faIcon: FontAwesomeIcons.userFriends,
                    title: 'Become a Disciple',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BecomeDiscipleScreen(
                            massian: _massian,
                          ),
                        ),
                      );
                    }),
                const Divider(
                  thickness: 0.8,
                ),
                ProfileTextButtons(
                    faIcon: FontAwesomeIcons.userFriends,
                    title: 'Become a Member',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BecomeMemberScreen(
                            massian: _massian,
                          ),
                        ),
                      );
                    }),
                const Divider(
                  thickness: 0.8,
                ),
                ProfileTextButtons(
                    faIcon: FontAwesomeIcons.dollarSign,
                    title: 'Support Us',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) => const SupportUsPage(),
                        ),
                      );
                    }),
                const Divider(
                  thickness: 0.8,
                ),
                RepositoryProvider(
                  create: (context) => AuthUserRepo(authService: AuthService()),
                  child: BlocProvider(
                    create: (context) => context.read<AuthStatusBloc>(),
                    child: BlocListener<AuthStatusBloc, AuthStatusState>(
                      listener: (context, state) {
                        if (state.authStatus == MassianAuthStatus.logOut) {}
                      },
                      child: ProfileTextButtons(
                          faIcon: FontAwesomeIcons.signOutAlt,
                          title: 'Log Out',
                          color: Colors.redAccent,
                          onPressed: () {
                            context.read<AuthStatusBloc>().add(LoggedOut());
                          }),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const HomeAdBox()
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
