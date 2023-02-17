import 'package:base_de_test/features/transactions/domain/repositories/boats_repository.dart';

import '../entities/entities.dart';
import 'update_boat_usecase.dart';

class UpdateBoatLocationUseCaseImpl implements UpdateBoatLocationUseCase {
  final BoatsRepository _repository;

  const UpdateBoatLocationUseCaseImpl(this._repository);

  @override
  Future<void> execute(
    final BoatId id,
    final String name,
    final IdentityNumber identityNumber,
    final OwnerEntity ownerEntity,
    final TypesOfBoat types,
    final CategoriesCNP cnp,
    final bool isAvailable,
    final DateTime onDispose,
    final DateTime unDispose,
    final String role,
  ) {
    return _repository.updateBoat(
      id,
      name,
      ownerEntity,
      types,
      identityNumber,
      cnp,
      isAvailable,
      onDispose,
      unDispose,
      role,
    );
  }
}
