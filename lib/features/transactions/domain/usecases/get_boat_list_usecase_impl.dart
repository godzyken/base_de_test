import 'package:base_de_test/features/transactions/domain/entities/boat_list_entity.dart';
import 'package:base_de_test/features/transactions/domain/repositories/boats_repository.dart';

import 'get_boat_list_usecase.dart';

class GetBoatListUseCaseImpl implements GetBoatListUseCase {
  final BoatsRepository _repository;

  const GetBoatListUseCaseImpl(this._repository);

  @override
  Future<BoatList> execute() => _repository.getBoatList();
}
