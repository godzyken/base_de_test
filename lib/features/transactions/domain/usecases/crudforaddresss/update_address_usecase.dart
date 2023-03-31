import 'package:base_de_test/features/transactions/domain/entities/entities.dart';

abstract class UpdateAddressUseCase {
  Future<void> execute(
    final AddressId id,
    final Docking docking,
    final String zipcode,
    final String city,
    final GeoEntity geo,
    final bool isValid,
  );
}
