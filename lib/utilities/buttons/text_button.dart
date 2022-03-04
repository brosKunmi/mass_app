import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';

class MassTextButton extends StatelessWidget {
  const MassTextButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          color: primaryColor,
          fontSize: 14,
        ),
      ),
    );
  }
}

class ProfileTextButtons extends StatelessWidget {
  final IconData faIcon;
  final String title;
  final VoidCallback onPressed;
  final Color? color;

  const ProfileTextButtons({
    Key? key,
    required this.faIcon,
    required this.title,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 12.0, bottom: 12.0),
            child: SizedBox(
              width: 16,
              child: FaIcon(
                faIcon,
                color: color ?? primaryColor,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: color ?? primaryColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
