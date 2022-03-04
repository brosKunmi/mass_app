import 'package:flutter/material.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class NoEventTile extends StatelessWidget {
  const NoEventTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
          child: 'Upcoming Events'.bigBold,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 200,
          margin: const EdgeInsets.all(6),
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: 'No event at the moment'.obText,
          ),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: otherBR,
            image: DecorationImage(
                image: AssetImage('blueIcon'.png), fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
