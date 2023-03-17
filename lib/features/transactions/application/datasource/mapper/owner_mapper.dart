import '../../../domain/entities/entities.dart';
import '../entity/boats_entity.dart' as s;

class OwnerMapper {
  static OwnerEntity transformToModel(final s.OwnerEntity entity) {
    return OwnerEntity(
        ownerId: OwnerId(value: entity['id']),
        name: entity['name'],
        phone: entity['phone']);
  }

  static s.OwnerEntity transformToMap(final OwnerEntity model) {
    return {
      'ownerId': model.ownerId.value,
      'name': model.name,
      'phone': model.phone,
    };
  }

  static s.OwnerEntity transformToNewEntityMap(
      final String name, final String phone) {
    return {
      'id': null,
      'name': name,
      'phone': phone,
    };
  }
}
