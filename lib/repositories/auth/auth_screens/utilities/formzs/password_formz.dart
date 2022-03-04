import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, empty }

class PasswordValid extends FormzInput<String, PasswordValidationError> {
  const PasswordValid.pure() : super.pure('');
  const PasswordValid.dirty([String value = '']) : super.dirty(value);

  static const _passLength = 8;
  static final _passRegExp = RegExp(r'^[A-Za-z\d@$!%*?&]{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    return _passRegExp.hasMatch(value) && value.length >= _passLength
        ? null
        : PasswordValidationError.invalid;
  }
}
