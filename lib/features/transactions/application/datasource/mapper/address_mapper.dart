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
    );
  }

  static s.AddressEntity transformToMap(final AddressEntity model) {
    return {
      'id': model.id?.value,
      'city': model.city,
      'zip_code': model.zipcode,
      'docking': model.docking,
      'geo': model.geo,
    };
  }

  static s.AddressEntity transformToNewEntityMap(final String city,
      final String zipcode, final Docking docking, final GeoEntity geo) {
    return {
      'id': null,
      'city': city,
      'zip_code': zipcode,
      'docking': docking,
      'geo': geo,
    };
  }
}
