import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mass_app/repositories/home/screens/home_screen.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: InkWell(
        onTap: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(userId: userId),
          ),
          ModalRoute.withName('/Home'),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: FaIcon(
                  FontAwesomeIcons.check,
                  color: primaryColor,
                  size: 50,
                ),
              ),
              const SizedBox(height: 50.0),
              'Details Submitted Successfully'.obText,
              const SizedBox(height: 12.0),
              'We Meuve!'.bigObText,
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: 'Tap anywhere to continue'.obText,
              )
            ],
          ),
        ),
      ),
    );
  }
}
