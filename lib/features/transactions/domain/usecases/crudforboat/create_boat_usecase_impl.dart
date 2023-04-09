import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:base_de_test/features/transactions/domain/repositories/boats_repository.dart';

import 'create_boat_usecase.dart';

class CreateBoatLocationCaseImpl implements CreateBoatLocationCase {
  final BoatsRepository _repository;

  const CreateBoatLocationCaseImpl(this._repository);

  @override
  Future<Boat> execute(
    final String name,
    final int ownerId,
    final int addressId,
    final String types,
    final String identityNumber,
    final String cnp,
    final bool isAvailable,
    final DateTime create,
    final DateTime rentedAt,
    final DateTime returnedAt,
    final String role,
  ) {
    return _repository.createBoat(
      name,
      ownerId,
      addressId,
      types,
      identityNumber,
      cnp,
      isAvailable,
      create,
      rentedAt,
      returnedAt,
      role,
    );
  }
}
