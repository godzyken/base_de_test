import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:base_de_test/features/transactions/domain/repositories/owner_repository.dart';

import 'delete_owner_usecase_impl.dart';

class DeleteOwnerEntityCaseImpl implements DeleteOwnerEntityCase {
  final OwnerRepository _repository;

  const DeleteOwnerEntityCaseImpl(this._repository);

  @override
  Future<void> execute(final OwnerId id) => _repository.deleteOwner(id);
}
