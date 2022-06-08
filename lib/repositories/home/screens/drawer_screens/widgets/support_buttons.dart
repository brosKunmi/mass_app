import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';

class SupportTextField extends StatelessWidget {
  const SupportTextField({
    Key? key,
    required this.hint,
    required this.onSubmitted,
    required this.inputType,
  }) : super(key: key);

  final String hint;
  final Function(String?) onSubmitted;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: inputType,
        style: GoogleFonts.montserrat(
          fontSize: 14,
        ),
        cursorColor: primaryColor,
        onSaved: onSubmitted,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade300,
          contentPadding:
              const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0),
          hintText: hint,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}

class SupportButton extends StatelessWidget {
  const SupportButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        Platform.isIOS ? 'Donate On the Website' : 'DONATE',
        style: GoogleFonts.montserrat(
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Platform.isIOS
            ? Size(MediaQuery.of(context).size.width * 0.8, 50)
            : const Size(100, 40),
        primary: const Color(0xff1B1869),
        padding: const EdgeInsets.all(4.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
