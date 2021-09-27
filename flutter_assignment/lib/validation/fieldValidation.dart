import 'package:formz/formz.dart';

enum FieldValidationError {
  empty,
  invalid
}

class FieldValidation extends FormzInput<String, FieldValidationError> {
  const FieldValidation.pure([String value = '']) : super.pure(value);
  const FieldValidation.dirty([String value = '']) : super.dirty(value);

  static final RegExp _regExp = RegExp(
    r'^.{3,11}$',
  );

  @override
  FieldValidationError validator(String value) {
    if (value?.isNotEmpty == false) {
      return FieldValidationError.empty;
    }
    return _regExp.hasMatch(value)
        ? null
        : FieldValidationError.invalid;
  }
}
extension Explanation on FieldValidationError {
  String get name {
    switch(this) {
      case FieldValidationError.invalid:
        return "Min of 3 and max of 11 characters are required";
      default:
        return null;
    }
  }
}