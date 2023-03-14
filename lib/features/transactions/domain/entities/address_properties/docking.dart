import 'package:formz/formz.dart';

import '../../../../auth/domain/entities/user_properties/name.dart';

class DockingFormz extends FormzInput<String, NameValidationError> {
  const DockingFormz.pure([super.value = '']) : super.pure();
  const DockingFormz.dirty([super.value = '']) : super.dirty();

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

  static String? showStreetNameErrorMessage(NameValidationError? error) {
    if (error == NameValidationError.empty) {
      return 'Empty Street name';
    } else if (error == NameValidationError.invalid) {
      return 'Too short street name';
    } else {
      return null;
    }
  }
}

class CityNameFormz extends FormzInput<String, NameValidationError> {
  const CityNameFormz.pure([super.value = '']) : super.pure();
  const CityNameFormz.dirty([super.value = '']) : super.dirty();

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

  static String? showCityNameErrorMessage(NameValidationError? error) {
    if (error == NameValidationError.empty) {
      return 'Empty City name';
    } else if (error == NameValidationError.invalid) {
      return 'Too short city name';
    } else {
      return null;
    }
  }
}

enum ZipcodeValidationError {
  empty,
  invalid,
  short;

  String getMessage() {
    switch (this) {
      case empty:
        return 'ZipCode can\'t be empty';
      case short:
        return 'ZipCode is too short';
      case invalid:
        return 'Must contain number only';
    }
  }
}

const String _zipCodePattern =
    r'^(?&lt;group5&gt;[0-9]{5})-?(?&lt;group4&gt;[0-9]{4})?';

class ZipCodeFormz extends FormzInput<String, ZipcodeValidationError> {
  const ZipCodeFormz.pure([super.value = '']) : super.pure();
  const ZipCodeFormz.dirty([super.value = '']) : super.dirty();

  static final _regex = RegExp(_zipCodePattern);
  static final _digitOnly = RegExp(_digitsOnlyPattern);

  @override
  ZipcodeValidationError? validator(String value) {
    if (_regex.hasMatch(value) && _digitOnly.hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return ZipcodeValidationError.empty;
    } else if (value.length < 4) {
      return ZipcodeValidationError.short;
    } else if (value.contains(' ')) {
      return ZipcodeValidationError.invalid;
    }
    return null;
  }

  static String? showZipCodeErrorMessage(ZipcodeValidationError? error) {
    if (error == ZipcodeValidationError.empty) {
      return 'Empty ZipCode';
    } else if (error == ZipcodeValidationError.invalid) {
      return 'Invalid ZipCode';
    } else if (error == ZipcodeValidationError.short) {
      return 'Zipcode too short';
    } else {
      return null;
    }
  }
}

enum GeoLocationError {
  invalid,
  empty,
  short,
  ;

  String getMessage() {
    switch (this) {
      case empty:
        return 'ZipCode can\'t be empty';
      case invalid:
        return 'Must contain number only';
      case short:
        return 'Must be contained 4 minimal Number';
    }
  }
}

const String _digitsOnlyPattern = r'^\d+$';

const String _latitudePattern =
    r'^(\\+|-)?(?:90(?:(?:\\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\\.[0-9]{1,6})?))$';

const String _longitudePattern =
    r'^(\\+|-)?(?:180(?:(?:\\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\\.[0-9]{1,6})?))$';

class LatFormz extends FormzInput<String, GeoLocationError> {
  const LatFormz.pure([super.value = '']) : super.pure();
  const LatFormz.dirty([super.value = '']) : super.dirty();

  static final _regex = RegExp(_latitudePattern);
  static final _digitsOnly = RegExp(_digitsOnlyPattern);

  @override
  GeoLocationError? validator(String value) {
    if (_regex.hasMatch(value) && _digitsOnly.hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return GeoLocationError.empty;
    } else if (value.length < 3) {
      return GeoLocationError.short;
    } else if (value.contains(' ')) {
      return GeoLocationError.invalid;
    }
    return null;
  }

  static String? showLatitudeErrorMessage(GeoLocationError? error) {
    if (error == GeoLocationError.empty) {
      return 'Empty latitude';
    } else if (error == GeoLocationError.invalid) {
      return 'Invalid latitude';
    } else if (error == GeoLocationError.short) {
      return 'latitude too short';
    } else {
      return null;
    }
  }
}

class LongFormz extends FormzInput<String, GeoLocationError> {
  const LongFormz.pure([super.value = '']) : super.pure();
  const LongFormz.dirty([super.value = '']) : super.dirty();

  static final _regex = RegExp(_longitudePattern);
  static final _digitsOnly = RegExp(_digitsOnlyPattern);

  @override
  GeoLocationError? validator(String value) {
    if (_regex.hasMatch(value) && _digitsOnly.hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return GeoLocationError.empty;
    } else if (value.length < 3) {
      return GeoLocationError.short;
    } else if (value.contains(' ')) {
      return GeoLocationError.invalid;
    }
    return null;
  }

  static String? showLongitudeErrorMessage(GeoLocationError? error) {
    if (error == GeoLocationError.empty) {
      return 'Empty longitude';
    } else if (error == GeoLocationError.invalid) {
      return 'Invalid longitude';
    } else if (error == GeoLocationError.short) {
      return 'longitude too short';
    } else {
      return null;
    }
  }
}
