import 'package:base_de_test/features/transactions/domain/entities/address/address_id.dart';

abstract class DeleteAddressEntityCase {
  Future<void> execute(final AddressId id);
}
