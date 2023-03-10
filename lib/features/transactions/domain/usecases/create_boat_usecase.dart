import '../entities/entities.dart';

abstract class CreateBoatLocationCase {
  Future<Boat> execute(
    final String name,
    final OwnerId ownerId,
    final OwnerEntity ownerEntity,
    final AddressId addressId,
    final AddressEntity addressEntity,
    final IdentityNumber identityNumber,
    final TypesOfBoat typesOfBoat,
    final CategoriesCNP cnp,
    final bool isAvailable,
    final DateTime create,
    final DateTime? deletedAt,
    final DateTime? rentedAt,
    final DateTime? returnedAt,
    final String role,
  );
}
