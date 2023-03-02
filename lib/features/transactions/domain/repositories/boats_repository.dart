import 'package:base_de_test/features/transactions/domain/entities/boat/boat_id.dart';

import '../entities/boat/boat_entity.dart';
import '../entities/boat/boat_list_entity.dart';

abstract class BoatsRepository {
  Stream<List<BoatList>> streamAllBoats();
  Future<BoatList> getBoatList();
  Future<Boat> createBoat(
      final String name,
      final OwnerEntity owner,
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
      final OwnerEntity owner,
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
}
