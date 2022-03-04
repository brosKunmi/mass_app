import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';

class CircularButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool filled;

  const CircularButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.filled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 10,
          fontWeight: filled ? FontWeight.w400 : FontWeight.normal,
        ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              color: filled ? Colors.white : Colors.transparent,
              width: filled ? 0.5 : 0.0),
        ),
        primary: filled ? Colors.transparent : primaryColor,
        minimumSize: const Size(80, 30),
      ),
    );
  }
}
