import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton(
      {Key? key,
      required this.filled,
      required this.text,
      required this.onPressed})
      : super(key: key);

  final bool filled;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          color: filled ? const Color(0xff1B1869) : Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
        primary: filled ? Colors.white : Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side:
              filled ? BorderSide.none : const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
