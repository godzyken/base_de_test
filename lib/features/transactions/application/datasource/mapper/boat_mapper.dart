import 'package:base_de_test/features/transactions/domain/entities/boat/boat_entity.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat/boat_id.dart';

import '../entity/boats_entity.dart';

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
        createdAt: DateTime.parse(entity['created_at']),
        deletedAt: DateTime.parse(entity['deleted_at']),
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
      'created_at': model.createdAt.toIso8601String(),
      'deleted_at': model.deletedAt?.toIso8601String(),
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
      final DateTime createdAt,
      final DateTime? deletedAt,
      final DateTime? rentedAt,
      final DateTime? returnedAt,
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
      'created_at': createdAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'rented_at': rentedAt?.toIso8601String(),
      'returned_at': returnedAt?.toIso8601String(),
      'role': role,
    };
  }
}
