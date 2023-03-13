import '../../../domain/entities/entities.dart';
import '../entity/boats_entity.dart';

class BoatMapper {
  static Boat transformToModel(final BoatEntity entity) {
    return Boat(
        boatId: BoatId(value: entity['id']),
        name: entity['name'],
        ownerId: OwnerId(value: entity['owner_id']),
        ownerEntity: OwnerEntity(
          ownerId: entity['id'],
          name: entity['owner_name'],
          phone: entity[''],
        ),
        addressEntity: AddressEntity(street: entity['street']),
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
      'owner_id': model.ownerId?.value,
      'ownerEntity': model.ownerEntity,
      'addressEntity': model.addressEntity,
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
      final OwnerId ownerId,
      final OwnerEntity owner,
      final AddressEntity address,
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
      'owner_id': ownerId,
      'ownerEntity': owner,
      'AddressEntity': address,
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
