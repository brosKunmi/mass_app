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
    return Scaffold(
      appBar: utilityAppBar('Help && FAQs'.bigBold),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: otherBR,
                image: DecorationImage(
                    image: AssetImage('blueIcon'.png), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  'Why MASS?'.artBold,
                  const SizedBox(height: 4),
                  'MASS is an acronym for the movement  which when fully spelt means Music According To The Scripture and the Street.'
                      .contentText,
                  const SizedBox(height: 8),
                  'What is MASS all about?'.artBold,
                  const SizedBox(height: 4),
                  'MASS is a Worship and Revival youth movement with a desire of drawing people to the body of Christ mostly through music.'
                      .contentText,
                  const SizedBox(height: 8),
                  'What are the goals and objectives of the MASS Movement?'
                      .artBold,
                  const SizedBox(height: 4),
                  'Mass is committed to raising kings and Priest who will rightful take their place and pay the price to ensure that the Kingdom of this world is subjected and converted to become the Kingdom of our God.'
                      .contentText,
                  const SizedBox(height: 8),
                  'Is MASS for the Catholics Alone?'.artBold,
                  const SizedBox(height: 4),
                  'No, MASS is a home for all and sundry especially those with an unquenchable and unrepentant desire to see the kingdom of God fully established on earth.'
                      .contentText,
                  const SizedBox(height: 8),
                  'Do I have to leave my Local Church to be part of the MASS Movement?'
                      .artBold,
                  const SizedBox(height: 4),
                  'MASS is not a church( in the context of of the usual conventional church), this makes it easy to worship at your local church without been deprived of the fellowship we enjoy at the mass movement.'
                      .contentText,
                  const SizedBox(height: 8),
                  'What are the requirements for Volunteering?'.artBold,
                  const SizedBox(height: 4),
                  'All you need is you and your willing heart, a teachable mind and an open spirit.'
                      .contentText,
                  const SizedBox(height: 8),
                  'For further help/ question contact: massmovementng@gmail.com'
                      .profText,
                  const SizedBox(height: 8),
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
