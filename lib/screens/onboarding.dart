import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mass_app/repositories/auth/auth_screens/screens/login_page.dart';
import 'package:mass_app/repositories/auth/auth_screens/screens/signup_page.dart';
import 'package:mass_app/utilities/buttons/onboarding_button.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _position = 0;

  final _images = ['image1'.jpg, 'image2'.jpg, 'image3'.jpg];

  final List<String> _texts = [
    'National Worship & Revival Gathering',
    'Explore Past and Upcoming Events',
    'Share with Others'
  ];

  final List<String> _bigTexts = [
    'WELCOME TO MASS',
    'STAY UP TO DATE',
    'SPREAD THE WORD'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
            items: List.generate(
              _images.length,
              (index) => Image.asset(
                _images[index],
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.multiply,
                color: const Color(0xff1B1869).withOpacity(0.5),
              ),
            ),
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.0,
                autoPlay: true,
                pageSnapping: false,
                disableCenter: true,
                autoPlayAnimationDuration: const Duration(seconds: 3),
                onPageChanged: (i, r) {
                  setState(() {
                    _position = i;
                  });
                }),
          ),
          Positioned(
              child: Image.asset(
                'mass_iconn'.png,
                height: 200,
                fit: BoxFit.cover,
              ),
              top: 10),
          Positioned(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: _bigTexts[_position].bigObText,
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 8.0),
                Container(
                  child: _texts[_position].obText,
                  alignment: Alignment.center,
                ),
                Row(
                  children: List.generate(
                    _images.length,
                    (index) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        color: _position == index
                            ? Colors.white
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                OnboardingButton(
                  filled: false,
                  text: 'SIGN IN',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                ),
                const SizedBox(height: 8.0),
                OnboardingButton(
                  filled: true,
                  text: 'GET STARTED',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    );
                  },
                ),
              ],
            ),
            bottom: 40,
          )
        ],
      ),
    );
  }
}
