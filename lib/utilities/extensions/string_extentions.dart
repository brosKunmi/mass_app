import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';

extension ImageString on String {
  String get jpg => 'assets/images/$this.jpg';
  String get png => 'assets/images/$this.png';
}

extension TextStrings on String {
  Text get obText => Text(
        this,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      );
  Text get bigObText => Text(
        this,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      );
  Text get authText => Text(
        this,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      );

  Text get bigLogin => Text(
        this,
        textAlign: TextAlign.start,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      );
  Text get bigBold => Text(
        this,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      );

  Text get profileBold => Text(
        this,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: primaryColor,
        ),
      );

  Text get profText => Text(
        this,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          color: primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      );

  Text get buttonText => Text(
        this,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      );

  Text get tileText => Text(
        this,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      );
  Text get vidText => Text(
        this,
        textAlign: TextAlign.start,
        overflow: TextOverflow.clip,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      );
  Text get vidSText => Text(
        this,
        textAlign: TextAlign.start,
        overflow: TextOverflow.clip,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      );

  Text get contentText => Text(
        this,
        overflow: TextOverflow.clip,
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w300,
          wordSpacing: 1.5,
        ),
      );
  Text get artBold => Text(
        this,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: primaryColor,
        ),
      );
}
