import 'package:base_de_test/features/auth/domain/entities/user_properties/name.dart';
import 'package:formz/formz.dart';

class BoatNameFormz extends FormzInput<String, NameValidationError> {
  const BoatNameFormz.pure([super.value = '']) : super.pure();
  const BoatNameFormz.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.empty;
    } else if (value.length < 3) {
      return NameValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showBoatNameErrorMessage(NameValidationError? error) {
    if (error == NameValidationError.empty) {
      return 'Empty Boat name';
    } else if (error == NameValidationError.invalid) {
      return 'Too short Boat name';
    } else {
      return null;
    }
  }
}

class BoatRoleFormz extends FormzInput<String, NameValidationError> {
  const BoatRoleFormz.pure([super.value = '']) : super.pure();
  const BoatRoleFormz.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.empty;
    } else if (value.length < 3) {
      return NameValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showBoatRoleErrorMessage(NameValidationError? error) {
    if (error == NameValidationError.empty) {
      return 'Empty Role name';
    } else if (error == NameValidationError.invalid) {
      return 'Too short Role name';
    } else {
      return null;
    }
  }
}
