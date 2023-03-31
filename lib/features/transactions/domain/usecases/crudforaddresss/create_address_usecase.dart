import '../../entities/entities.dart';

abstract class CreateAddressEntityCase {
  Future<AddressEntity> execute(
    final String docking,
    final String city,
    final String zipcode,
    final String? geo,
    final bool isValid,
  );
}
