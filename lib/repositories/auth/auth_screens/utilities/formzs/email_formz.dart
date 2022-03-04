import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class EmailValid extends FormzInput<String, EmailValidationError> {
  EmailValid.pure() : super.pure('');

  EmailValid.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  EmailValidationError? validator(value) {
    return _emailRegExp.hasMatch(value)
        ? null
        : value.isEmpty
            ? null
            : EmailValidationError.invalid;
  }
}
