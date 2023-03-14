import '../entities/entities.dart';

abstract class UpdateBoatLocationUseCase {
  Future<void> execute(
    final BoatId id,
    final String name,
    final OwnerId ownerId,
    final IdentityNumber identityNumber,
    final OwnerEntity ownerEntity,
    final AddressId addressId,
    final AddressEntity addressEntity,
    final TypesOfBoat types,
    final CategoriesCNP cnp,
    final bool isAvailable,
    final DateTime createdAt,
    final DateTime? deletedAt,
    final DateTime? rentedAt,
    final DateTime? returnedAt,
    final String role,
  );
}
