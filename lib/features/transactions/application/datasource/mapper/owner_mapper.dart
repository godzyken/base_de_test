import '../../../domain/entities/entities.dart';
import '../entity/boats_entity.dart' as s;

class OwnerMapper {
  static OwnerEntity transformToModel(final s.OwnerEntity entity) {
    return OwnerEntity(
        ownerId: OwnerId(value: entity['id']),
        name: entity['name'],
        phone: entity['phone'],
        isValid: entity['is_valid'] == 1);
  }

  static s.OwnerEntity transformToMap(final OwnerEntity model) {
    return {
      'ownerId': model.ownerId.value,
      'name': model.name,
      'phone': model.phone,
      'is_valid': model.isValid ? 1 : 0,
    };
  }

  static s.OwnerEntity transformToNewEntityMap(
      final String name, final String phone, bool isValid) {
    return {
      'id': null,
      'name': name,
      'phone': phone,
      'is_valid': isValid ? 1 : 0,
    };
  }
}
