import '../../../domain/entities/entities.dart';
import '../entity/boats_entity.dart' as s;

class AddressMapper {
  static AddressEntity transformToModel(final s.AddressEntity entity) {
    return AddressEntity(
      id: AddressId(value: entity['id']),
      city: entity['city'],
      zipcode: entity['zip'],
      docking: entity['docking'],
      geo: entity['geo'],
      isValid: entity['isValid'],
    );
  }

  static s.AddressEntity transformToMap(final AddressEntity model) {
    return {
      'id': model.id?.value,
      'city': model.city,
      'zip_code': model.zipcode,
      'docking': model.docking,
      'geo': model.geo,
      'isValid': model.isValid,
    };
  }

  static s.AddressEntity transformToNewEntityMap(
      final String city,
      final String zipcode,
      final String docking,
      final String? geo,
      final bool isValid) {
    return {
      'id': null,
      'city': city,
      'zip_code': zipcode,
      'docking': docking,
      'geo': geo,
      'isValid': isValid,
    };
  }
}
