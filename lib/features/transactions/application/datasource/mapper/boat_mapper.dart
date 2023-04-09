import '../../../domain/entities/entities.dart';
import '../entity/boats_entity.dart';

class BoatMapper {
  static Boat transformToModel(final BoatEntity entity) {
    return Boat(
        boatId: BoatId(value: entity['id']),
        name: entity['name'],
        ownerId: OwnerId(value: entity['owner_id']),
        addressId: AddressId(value: entity['address_id']),
        types: entity['boat_types'],
        identityNumber: entity['identity_number'],
        cnp: entity['cat_cnp'],
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
      'address_id': model.addressId?.value,
      'boat_types': model.types,
      'cat_cnp': model.cnp,
      'identity_number': model.identityNumber,
      'is_available': model.isAvailable ? 1 : 0,
      'created_at': model.createdAt.toIso8601String(),
      'deleted_at': model.deletedAt?.toIso8601String(),
      'rented_at': model.rentedAt.toIso8601String(),
      'returned_at': model.returnedAt.toIso8601String(),
      'role': model.role,
    };
  }

  static BoatEntity transformToNewEntityMap(
      final String name,
      final int ownerId,
      final int addressId,
      final String typesOfBoat,
      final String identityNumber,
      final String cnp,
      final bool isAvailable,
      final DateTime createdAt,
      final DateTime rentedAt,
      final DateTime returnedAt,
      final String role) {
    return {
      'id': null,
      'name': name,
      'owner_id': ownerId,
      'address_id': addressId,
      'boat_types': typesOfBoat,
      'cat_cnp': cnp,
      'identity_number': identityNumber,
      'is_available': isAvailable ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'rented_at': rentedAt.toIso8601String(),
      'returned_at': returnedAt.toIso8601String(),
      'role': role,
    };
  }
}
