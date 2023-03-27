import 'package:base_de_test/features/transactions/domain/entities/entities.dart';

abstract class AddressRepository {
  Future<AddressList> getAddressList();
  Future<AddressEntity> createAddress(final Docking docking, final String city,
      final String zipcode, final GeoEntity geo, bool isValid);
  Future<void> updateAddress(
      final AddressId id,
      final Docking docking,
      final String city,
      final String zipcode,
      final GeoEntity geo,
      final bool isValid);
  Future<int> deleteAddress(final AddressId id);
}
