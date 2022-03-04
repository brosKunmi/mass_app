import 'package:flutter/material.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class HomeRowButtons extends StatelessWidget {
  const HomeRowButtons({
    Key? key,
    required this.image,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String image;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6.0),
        height: 130,
        width: 100,
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[6],
          color: Colors.white,
          borderRadius: buttonBR,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: commonR,
                topRight: commonR,
              ),
              child: Image.asset(
                image.png,
                height: 80,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: text.buttonText,
            )),
          ],
        ),
      ),
    );
  }
}
