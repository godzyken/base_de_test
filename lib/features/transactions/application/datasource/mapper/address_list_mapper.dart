import 'package:base_de_test/features/transactions/application/datasource/entity/boats_entity.dart';
import 'package:base_de_test/features/transactions/application/datasource/mapper/address_mapper.dart';

import '../../../domain/entities/address/address_list_entity.dart';

class AddressListMapper {
  static AddressList transformToModel(final AddressListEntity entities) {
    final values =
        entities.map((e) => AddressMapper.transformToModel(e)).toList();
    return AddressList(values: values);
  }

  static AddressListEntity transformToMap(final AddressList model) =>
      model.values.map((e) => AddressMapper.transformToMap(e)).toList();
}
