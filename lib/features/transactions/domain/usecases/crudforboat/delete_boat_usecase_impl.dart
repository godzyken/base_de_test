import 'package:base_de_test/features/transactions/domain/entities/boat/boat_id.dart';
import 'package:base_de_test/features/transactions/domain/repositories/boats_repository.dart';

import 'delete_boat_usecase.dart';

class DeleteBoatLocationUseCaseImpl implements DeleteBoatLocationUseCase {
  final BoatsRepository _repository;

  const DeleteBoatLocationUseCaseImpl(this._repository);

  @override
  Future<void> execute(final BoatId id) => _repository.deleteBoat(id);
}
