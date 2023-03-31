import 'package:base_de_test/features/transactions/domain/entities/address/address_entity.dart';
import 'package:base_de_test/features/transactions/domain/entities/address/address_id.dart';
import 'package:base_de_test/features/transactions/domain/repositories/address_repository.dart';

import 'update_address_usecase.dart';

class UpdateAddressUseCaseImpl implements UpdateAddressUseCase {
  final AddressRepository _repository;

  const UpdateAddressUseCaseImpl(this._repository);

  @override
  Future<void> execute(
      final AddressId id,
      final Docking docking,
      final String zipcode,
      final String city,
      final GeoEntity geo,
      final bool isValid) {
    return _repository.updateAddress(
      id,
      docking.name,
      city,
      zipcode,
      geo.toString(),
      isValid,
    );
  }
}
