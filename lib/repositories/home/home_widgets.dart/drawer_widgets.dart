import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mass_app/repositories/home/screens/drawer_screens/about_us.dart';
import 'package:mass_app/repositories/home/screens/drawer_screens/contact_us.dart';
import 'package:mass_app/repositories/home/screens/drawer_screens/help_faq_screen.dart';
import 'package:mass_app/repositories/home/screens/drawer_screens/support_us.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidgets extends StatelessWidget {
  const DrawerWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Image.asset(
            'mass_iconn'.png,
            height: 180,
            fit: BoxFit.cover,
          ),
          drawerTexts(
              icon: FontAwesomeIcons.addressCard,
              text: 'About Us',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AboutUsScreen()),
                );
              }),
          drawerTexts(
              icon: FontAwesomeIcons.addressBook,
              text: 'Contact Us',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ContactUsPage()),
                );
              }),
          drawerTexts(
              icon: FontAwesomeIcons.dollarSign,
              text: 'Support Us',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) => const SupportUsPage()));
              }),
          drawerTexts(
              icon: FontAwesomeIcons.questionCircle,
              text: 'Help and FAQs',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const HelpAndFAQs()),
                );
              }),
          drawerTexts(
              icon: FontAwesomeIcons.stickyNote,
              text: 'Privacy Policy',
              onTap: () {
                _launchURL();
              }),
        ],
      ),
    );
  }

  _launchURL() async {
    const _url = 'https://www.masscitytour.com.ng/privacy';

    if (await canLaunch(_url)) {
      await launch(_url, enableJavaScript: true);
    } else {
      throw 'Could not launch $_url';
    }
  }

  Widget drawerTexts(
      {required String text,
      required IconData icon,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextButton.icon(
        onPressed: onTap,
        icon: FaIcon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          text,
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
      ),
    );
  }
}
