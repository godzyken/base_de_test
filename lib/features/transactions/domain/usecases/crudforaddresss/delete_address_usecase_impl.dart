import 'package:base_de_test/features/transactions/domain/entities/address/address_id.dart';
import 'package:base_de_test/features/transactions/domain/repositories/address_repository.dart';

import 'delete_address_usecase.dart';

class DeleteAddressEntityCaseImpl implements DeleteAddressEntityCase {
  final AddressRepository _repository;

  const DeleteAddressEntityCaseImpl(this._repository);

  @override
  Future<void> execute(final AddressId id) => _repository.deleteAddress(id);
}
