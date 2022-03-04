import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mass_app/repositories/ads/widgets/home_ad_box.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: utilityAppBar('Contact Us'.bigBold),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center(child: 'GET IN TOUCH WITH THE MINISTRY'.bigBold),
            'Have an important message or request to get across to us? Reach us now!'
                .contentText,
            const SizedBox(height: 20),
            'Address'.artBold,
            const SizedBox(height: 4),
            'Plot 13, Mojeed Adekunle Street, Lekki-Epe Way, Ajah, Lagos'
                .bigBold,
            const SizedBox(height: 20),
            'Phone'.artBold,
            const SizedBox(height: 4),
            '+234 803 337 9191'.bigBold,
            const SizedBox(height: 20),
            'Email'.artBold,
            const SizedBox(height: 4),
            'massmovementng@gmail.com'.bigBold,
            const SizedBox(height: 20),
            'Find Us Here'.artBold,
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _launchURL(3);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.facebook,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _launchURL(0);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.instagram,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _launchURL(1);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.twitter,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _launchURL(2);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.youtube,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const HomeAdBox()
          ],
        ),
      ),
    );
  }
}

_launchURL(int n) async {
  const urls = [
    'https://www.instagram.com/mass_movement/',
    'https://twitter.com/mass_movement',
    'https://www.youtube.com/channel/UCWdUXCx662coGi0E8FQ_5nA',
    'https://web.facebook.com/massmovementglobal/'
  ];

  if (await canLaunch(urls[n])) {
    await launch(urls[n], enableJavaScript: true);
  } else {
    throw 'Could not launch ${urls[n]}';
  }
}
