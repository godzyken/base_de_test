import 'package:formz/formz.dart';

import '../../../../auth/domain/entities/user_properties/name.dart';

class OwnerNameFormz extends FormzInput<String, NameValidationError> {
  const OwnerNameFormz.pure([super.value = '']) : super.pure();
  const OwnerNameFormz.dirty([super.value = '']) : super.dirty();

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

  static String? showOwnerNameErrorMessage(NameValidationError? error) {
    if (error == NameValidationError.empty) {
      return 'Empty Owner name';
    } else if (error == NameValidationError.invalid) {
      return 'Too short owner name';
    } else {
      return null;
    }
  }
}

enum PhoneFormatError {
  invalid,
  empty,
  short,
  ;

  String getMessage() {
    switch (this) {
      case empty:
        return 'Phone number can\'t be empty';
      case invalid:
        return 'Must contain phone number';
      case short:
        return 'Must be contained 5 minimal Number';
    }
  }
}

const String _phonePattern = r'^\+(?:[0-9]●?){6,14}[0-9]$';

class OwnerPhoneFormz extends FormzInput<String, PhoneFormatError> {
  const OwnerPhoneFormz.pure([super.value = '']) : super.pure();
  const OwnerPhoneFormz.dirty([super.value = '']) : super.dirty();

  static final _regex = RegExp(_phonePattern);

  @override
  PhoneFormatError? validator(String value) {
    if (_regex.hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return PhoneFormatError.empty;
    } else if (value.length < 3) {
      return PhoneFormatError.short;
    } else if (value.contains(' ')) {
      return PhoneFormatError.invalid;
    }
    return null;
  }

  static String? showPhoneFormatErrorMessage(PhoneFormatError? error) {
    if (error == PhoneFormatError.empty) {
      return 'Empty phone number';
    } else if (error == PhoneFormatError.invalid) {
      return 'Invalid phone format';
    } else if (error == PhoneFormatError.short) {
      return 'Phone format too short';
    } else {
      return null;
    }
  }
}
