import 'package:base_de_test/features/transactions/application/datasource/mapper/owner_mapper.dart';
import 'package:base_de_test/features/transactions/domain/entities/entities.dart';

import '../entity/boats_entity.dart';

class OwnerListMapper {
  static OwnerList transformToModel(final OwnerListEntity entities) {
    final values =
        entities.map((e) => OwnerMapper.transformToModel(e)).toList();
    return OwnerList(values: values);
  }

  static OwnerListEntity transformToMap(final OwnerList model) =>
      model.values.map((e) => OwnerMapper.transformToMap(e)).toList();
}
