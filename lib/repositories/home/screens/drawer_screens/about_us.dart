import 'package:flutter/material.dart';

import 'package:mass_app/repositories/ads/widgets/home_ad_box.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/extensions/utility_strings.dart';

import 'package:mass_app/utilities/widgets/utility_widgets.dart';

import '../../../ads/widgets/home_ad_box.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

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
              'art_charge'.png,
              width: double.infinity,
              height: _tHeight * 0.3,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: UtilityStrings.aboutUs.contentText,
            ),
            const SizedBox(height: 20),
            const HomeAdBox()
          ],
        ),
      ),
    );
  }
}
