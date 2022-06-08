import 'package:flutter/material.dart';
import 'package:mass_app/repositories/ads/widgets/home_ad_box.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

import '../../../../utilities/colors and doubles/colors.dart';
import '../../../../utilities/colors and doubles/doubles.dart';
import '../../../../utilities/widgets/utility_widgets.dart';

class HelpAndFAQs extends StatelessWidget {
  const HelpAndFAQs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: utilityAppBar('Help & FAQs'.bigObText, color: Colors.white),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: _size.width,
              height: _size.height * 0.4,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: otherBR,
                image: DecorationImage(
                    image: AssetImage('blueIcon'.png), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  'Why MASS?'.artBold2,
                  const SizedBox(height: 4),
                  'MASS is a Worship and Revival Missions Agency that utilize Music,Creative Arts and other Innovative Media Channels for Kingdom expansion and registered under Nigerian Laws as MASS GLOBAL IMPACT FOUNDATION (CAC/IT/No: 151694), although popularly known as THE MASS MOVEMENT.'
                      .contentText,
                  // const SizedBox(height: 12),
                  // 'What is MASS all about?'.artBold2,
                  // const SizedBox(height: 4),
                  // 'MASS is a Worship and Revival youth movement with a desire of drawing people to the body of Christ mostly through music.'
                  //     .contentText,
                  const SizedBox(height: 12),
                  'What are the goals and objectives of The MASS Movement?'
                      .artBold2,
                  const SizedBox(height: 4),
                  'MASS are committed to raising Kings and Priest who will take their rightful place and pay the price to ensure that the Kingdoms of this world becomes the Kingdom of our God and of His Christ.'
                      .contentText,
                  const SizedBox(height: 12),
                  'Is MASS for the Catholics Alone?'.artBold2,
                  const SizedBox(height: 4),
                  'No,MASS is an acronym which stems from our worship crusades known as Music According to The Streets and Scriptures (MASS). MASS is a home for all and sundry especially those with an unquenchable and unrepentant desire to see the Kingdom of God fully established here on earth.'
                      .contentText,
                  const SizedBox(height: 12),
                  'Do I have to leave my Local Church to be part of the MASS Movement?'
                      .artBold2,
                  const SizedBox(height: 4),
                  'MASS is not a church( in the context of of the usual conventional church). This makes it easy to worship at your local church without been deprived of the fellowship we enjoy at the MASS Movement.'
                      .contentText,
                  const SizedBox(height: 12),
                  'What are the requirements for Volunteering?'.artBold2,
                  const SizedBox(height: 4),
                  'All you need is you and your willing heart, a teachable mind and an open spirit.'
                      .contentText,
                  const SizedBox(height: 12),
                  'For further help/ question contact: massmovementng@gmail.com'
                      .profText,
                  const SizedBox(height: 12),
                  const HomeAdBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
