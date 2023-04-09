import 'package:base_de_test/features/transactions/domain/entities/entities.dart';

abstract class UpdateBoatLocationUseCase {
  Future<void> execute(
    final BoatId id,
    final String name,
    final OwnerId ownerId,
    final IdentityNumber identityNumber,
    final AddressId addressId,
    final TypesOfBoat types,
    final CategoriesCNP cnp,
    final bool isAvailable,
    final DateTime createdAt,
    final DateTime deletedAt,
    final DateTime rentedAt,
    final DateTime returnedAt,
    final String role,
  );
}
