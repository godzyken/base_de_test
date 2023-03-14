import '../entities/entities.dart';

abstract class BoatsRepository {
  Stream<List<BoatList>> streamAllBoats();
  Future<BoatList> getBoatList();
  Future<Boat> createBoat(
      final String name,
      final OwnerId ownerId,
      final OwnerEntity owner,
      final AddressId addressId,
      final AddressEntity address,
      final TypesOfBoat types,
      final IdentityNumber identityNumber,
      final CategoriesCNP cnp,
      final bool available,
      final DateTime createdAt,
      final DateTime? deletedAt,
      final DateTime? rentedAt,
      final DateTime? returnedAt,
      final String? role);
  Future<void> updateBoat(
      final BoatId id,
      final String name,
      final OwnerId ownerId,
      final OwnerEntity owner,
      final AddressId addressId,
      final AddressEntity address,
      final TypesOfBoat types,
      final IdentityNumber identityNumber,
      final CategoriesCNP cnp,
      final bool isAvailable,
      final DateTime createdAt,
      final DateTime? deletedAt,
      final DateTime? rentedAt,
      final DateTime? returnedAt,
      final String? role);
  Future<void> deleteBoat(final BoatId id);
  Future<void> closeDatabase();
}
