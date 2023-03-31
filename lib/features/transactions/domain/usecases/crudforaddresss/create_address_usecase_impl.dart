import 'package:base_de_test/features/transactions/domain/entities/address/address_entity.dart';
import 'package:base_de_test/features/transactions/domain/repositories/address_repository.dart';

import 'create_address_usecase.dart';

class CreateAddressEntityCaseImpl implements CreateAddressEntityCase {
  final AddressRepository _repository;

  const CreateAddressEntityCaseImpl(this._repository);

  @override
  Future<AddressEntity> execute(
    final String docking,
    final String city,
    final String zipcode,
    final String? geo,
    final bool isValid,
  ) {
    return _repository.createAddress(docking, city, zipcode, geo!, isValid);
  }
}
