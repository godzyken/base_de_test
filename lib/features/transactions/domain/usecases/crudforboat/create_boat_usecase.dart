import '../../entities/entities.dart';

abstract class CreateBoatLocationCase {
  Future<Boat> execute(
    final String name,
    final int ownerId,
    final int addressId,
    final String identityNumber,
    final String typesOfBoat,
    final String cnp,
    final bool isAvailable,
    final DateTime create,
    final DateTime? deletedAt,
    final DateTime? rentedAt,
    final DateTime? returnedAt,
    final String role,
  );
}
