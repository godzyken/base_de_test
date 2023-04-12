import 'package:base_de_test/features/transactions/domain/entities/entities.dart';

abstract class AddressRepository {
  Stream<List<AddressList>> streamAllAddress();
  Future<AddressList> getAddressList();
  Future<AddressEntity> createAddress(final String docking, final String city,
      final String zipcode, final String geo, bool isValid);
  Future<void> updateAddress(
      final AddressId id,
      final Docking docking,
      final String city,
      final String zipcode,
      final String geo,
      final bool isValid);
  Future<int> deleteAddress(final AddressId id);
  Future<void> closeDatabase();
}
