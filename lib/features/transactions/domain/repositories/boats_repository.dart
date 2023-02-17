import 'package:base_de_test/features/transactions/domain/entities/boat_id.dart';

import '../entities/boat_entity.dart';
import '../entities/boat_list_entity.dart';

abstract class BoatsRepository {
  Future<BoatList> getBoatList();
  Future<Boat> createBoat(
      final String name,
      final OwnerEntity owner,
      final TypesOfBoat types,
      final IdentityNumber identityNumber,
      final CategoriesCNP cnp,
      final bool available,
      final DateTime? createdAt,
      final String? role);
  Future<void> updateBoat(
      final BoatId id,
      final String name,
      final OwnerEntity owner,
      final TypesOfBoat types,
      final IdentityNumber identityNumber,
      final CategoriesCNP cnp,
      final bool isAvailable,
      final DateTime? createdAt,
      final DateTime? removedAt,
      final String? role);
  Future<void> deleteBoat(final BoatId id);
}
