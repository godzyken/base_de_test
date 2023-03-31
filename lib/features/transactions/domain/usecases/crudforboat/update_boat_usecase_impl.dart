import 'package:base_de_test/features/transactions/domain/repositories/boats_repository.dart';

import '../../entities/entities.dart';
import 'update_boat_usecase.dart';

class UpdateBoatLocationUseCaseImpl implements UpdateBoatLocationUseCase {
  final BoatsRepository _repository;

  const UpdateBoatLocationUseCaseImpl(this._repository);

  @override
  Future<void> execute(
    final BoatId id,
    final String name,
    final OwnerId ownerId,
    final IdentityNumber identityNumber,
    final AddressId addressId,
    final TypesOfBoat types,
    final CategoriesCNP cnp,
    final bool isAvailable,
    final DateTime createdAt,
    final DateTime? deletedAt,
    final DateTime? rentedAt,
    final DateTime? returnedAt,
    final String role,
  ) {
    return _repository.updateBoat(
      id,
      name,
      ownerId,
      addressId,
      types,
      identityNumber,
      cnp,
      isAvailable,
      createdAt,
      deletedAt!,
      returnedAt!,
      returnedAt,
      role,
    );
  }
}
