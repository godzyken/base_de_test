import 'package:base_de_test/features/common/domain/failures/failure.dart';
import 'package:base_de_test/features/common/domain/values/value_abstract.dart';
import 'package:fpdart/fpdart.dart';

class BoatName extends ValueAbstract<String> {
  factory BoatName(String input) {
    return BoatName._(
      _validate(input),
    );
  }

  const BoatName._(this._value);

  @override
  Either<Failure, String> get value => _value;

  final Either<Failure, String> _value;
}

Either<Failure, String> _validate(String input) {
  if (input.length >= 2) {
    return right(input);
  }
  return left(
    Failure.unprocessableEntity(
      message: 'The name must be a least 2 characters in length',
    ),
  );
}
