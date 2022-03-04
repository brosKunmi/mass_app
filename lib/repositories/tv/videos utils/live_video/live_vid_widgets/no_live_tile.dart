import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class NoLiveTile extends StatelessWidget {
  const NoLiveTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 200,
          alignment: Alignment.center,
          child: Image.asset('mass_tv'.png),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        Positioned(
          right: 8,
          top: 3,
          child: Text(
            'LIVE',
            style: GoogleFonts.montserrat(
                fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          bottom: 12,
          child: 'No Live Event'.vidText,
        ),
      ],
    );
  }
}

class LiveLoadingSpin extends StatelessWidget {
  const LiveLoadingSpin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitThreeInOut(
          color: primaryColor,
          size: 32,
        ),
        const SizedBox(width: 8),
        'checking for live event'.profText,
        SpinKitThreeInOut(
          color: primaryColor,
          size: 32,
        ),
      ],
    );
  }
}
