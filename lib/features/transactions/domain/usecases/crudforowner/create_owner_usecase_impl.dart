import 'package:base_de_test/features/transactions/domain/entities/owner/owner_entity.dart';
import 'package:base_de_test/features/transactions/domain/repositories/owner_repository.dart';

import 'create_owner_usecase.dart';

class CreateOwnerEntityCaseImpl implements CreateOwnerEntityCase {
  final OwnerRepository _repository;

  const CreateOwnerEntityCaseImpl(this._repository);

  @override
  Future<OwnerEntity> execute(
    final String name,
    final String phone,
    final bool isValid,
  ) {
    return _repository.createOwner(name, phone, isValid);
  }
}
