import 'package:base_de_test/features/transactions/application/datasource/entity/boats_entity.dart';
import 'package:base_de_test/features/transactions/application/datasource/mapper/boat_mapper.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat/boat_list_entity.dart';

class BoatListMapper {
  static BoatList transformToModel(final BoatListEntity entities) {
    final values = entities.map((e) => BoatMapper.transformToModel(e)).toList();
    return BoatList(values: values);
  }

  static BoatListEntity transformToMap(final BoatList model) =>
      model.values.map((e) => BoatMapper.transformToMap(e)).toList();
}
