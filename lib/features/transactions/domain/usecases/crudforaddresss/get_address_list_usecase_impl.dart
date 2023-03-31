import 'package:base_de_test/features/transactions/domain/entities/address/address_list_entity.dart';
import 'package:base_de_test/features/transactions/domain/repositories/address_repository.dart';

import 'get_address_list_usecase.dart';

class GetAddressListUseCaseImpl implements GetAddressListUseCase {
  final AddressRepository _repository;

  const GetAddressListUseCaseImpl(this._repository);

  @override
  Future<AddressList> execute() => _repository.getAddressList();

  @override
  Stream<List<AddressList>> streamAddress() => _repository.streamAllAddress();
}
