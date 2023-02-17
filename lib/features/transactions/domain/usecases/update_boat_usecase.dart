import '../entities/entities.dart';

abstract class UpdateBoatLocationUseCase {
  Future<void> execute(
    final BoatId id,
    final String name,
    final IdentityNumber identityNumber,
    final OwnerEntity ownerEntity,
    final TypesOfBoat types,
    final CategoriesCNP cnp,
    final bool isAvailable,
    final DateTime onDispose,
    final DateTime unDispose,
    final String role,
  );
}
