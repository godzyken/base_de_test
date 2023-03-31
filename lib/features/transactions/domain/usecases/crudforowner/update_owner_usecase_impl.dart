import 'package:base_de_test/features/transactions/domain/entities/owner/owner_id.dart';
import 'package:base_de_test/features/transactions/domain/repositories/owner_repository.dart';

import 'update_owner_usecase.dart';

class UpdateOwnerUseCaseImpl implements UpdateOwnerUseCase {
  final OwnerRepository _repository;

  const UpdateOwnerUseCaseImpl(this._repository);

  @override
  Future<void> execute(final OwnerId id, final String name, final String phone,
      final bool isValid) {
    return _repository.updateOwner(id, name, phone, isValid);
  }
}
