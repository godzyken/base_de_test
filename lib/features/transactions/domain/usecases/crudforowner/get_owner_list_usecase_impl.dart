import 'package:base_de_test/features/transactions/domain/entities/owner/owner_list_entity.dart';
import 'package:base_de_test/features/transactions/domain/repositories/owner_repository.dart';

import 'get_owner_list_usecase.dart';

class GetOwnerListUseCaseImpl implements GetOwnerListUseCase {
  final OwnerRepository _repository;

  const GetOwnerListUseCaseImpl(this._repository);

  @override
  Future<OwnerList> execute() => _repository.getOwnerList();

  @override
  Stream<List<OwnerList>> streamOwners() => streamOwners();
}
