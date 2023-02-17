import 'package:base_de_test/features/transactions/application/datasource/entity/boats_entity.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat_entity.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat_id.dart';

class BoatMapper {
  static Boat transformToModel(final BoatEntity entity) {
    return Boat(
        boatId: BoatId(value: entity['id']),
        name: entity['name'],
        ownerEntity: entity['owner'],
        types: entity['types'],
        identityNumber: entity['matriculation'],
        cnp: entity['cnp'],
        isAvailable: entity['is_available'] == 1,
        rentedAt: DateTime.parse(entity['rent_date']),
        returnedAt: DateTime.parse(entity['return_date']),
        role: entity['role']);
  }

  static BoatEntity transformToMap(final Boat model) {
    return {
      'id': model.boatId?.value,
      'name': model.name,
      'ownerEntity': model.ownerEntity,
      'types': model.types,
      'cnp': model.cnp,
      'identity_number': model.identityNumber,
      'is_available': model.isAvailable ? 1 : 0,
      'rented_at': model.rentedAt?.toIso8601String(),
      'returned_at': model.returnedAt?.toIso8601String(),
      'role': model.role,
    };
  }

  static BoatEntity transformToNewEntityMap(
      final String name,
      final OwnerEntity owner,
      final CategoriesCNP cnp,
      final IdentityNumber identityNumber,
      final bool isAvailable,
      final DateTime rentedAt,
      final TypesOfBoat typesOfBoat,
      final String role) {
    return {
      'id': null,
      'name': name,
      'ownerEntity': owner,
      'types': typesOfBoat,
      'cnp': cnp,
      'identity_number': identityNumber,
      'is_available': isAvailable ? 1 : 0,
      'rented_at': rentedAt.toIso8601String(),
      'role': role,
    };
  }
}
