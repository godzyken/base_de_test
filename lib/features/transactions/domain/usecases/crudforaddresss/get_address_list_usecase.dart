import 'package:base_de_test/features/transactions/domain/entities/address/address_list_entity.dart';

abstract class GetAddressListUseCase {
  Future<AddressList> execute();

  Stream<List<AddressList>> streamAddress();
}
