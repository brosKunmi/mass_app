import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final String? label;
  final Function(String?) onSubmitted;
  final String? initial;
  final String? hint;

  const AuthTextField(
      {Key? key,
      required this.keyboardType,
      required this.onSubmitted,
      this.label,
      this.hint,
      this.initial})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        initialValue: initial ?? '',
        keyboardType: keyboardType,
        style: GoogleFonts.montserrat(
          fontSize: 14,
        ),
        onSaved: onSubmitted,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint ?? '',
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14,
            color: Colors.black,
          ),
          labelStyle: GoogleFonts.montserrat(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class AuthPasswordField extends StatefulWidget {
  final String label;

  final Function(String?) onSubmitted;

  const AuthPasswordField({
    Key? key,
    required this.label,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: _obscure,
        style: GoogleFonts.montserrat(
          fontSize: 14,
        ),
        onSaved: widget.onSubmitted,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            alignment: Alignment.bottomCenter,
            onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
            icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
            iconSize: 16,
            color: Colors.black,
          ),
          labelText: widget.label,
          labelStyle: GoogleFonts.montserrat(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
