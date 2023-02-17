import 'package:base_de_test/features/transactions/domain/entities/boat_entity.dart';
import 'package:base_de_test/features/transactions/domain/repositories/boats_repository.dart';

import 'create_boat_usecase.dart';

class CreateBoatLocationCaseImpl implements CreateBoatLocationCase {
  final BoatsRepository _repository;

  const CreateBoatLocationCaseImpl(this._repository);

  @override
  Future<Boat> execute(
    final String name,
    final OwnerEntity ownerEntity,
    final IdentityNumber identityNumber,
    final TypesOfBoat types,
    final CategoriesCNP cnp,
    final bool isAvailable,
    final DateTime create,
    final String role,
  ) {
    return _repository.createBoat(
      name,
      ownerEntity,
      types,
      identityNumber,
      cnp,
      isAvailable,
      create,
      role,
    );
  }
}
