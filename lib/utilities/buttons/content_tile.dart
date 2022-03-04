import 'package:flutter/material.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class ContentTile extends StatelessWidget {
  const ContentTile(
      {Key? key, required this.onTap, required this.image, required this.text})
      : super(key: key);

  final VoidCallback onTap;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6.0),
        //  height: 250,
        width: 200,
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
                height: 120,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: text.tileText,
            )),
          ],
        ),
      ),
    );
  }
}
