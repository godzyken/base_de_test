import '../../entities/entities.dart';

abstract class CreateBoatLocationCase {
  Future<Boat> execute(
    final String name,
    final int ownerId,
    final int addressId,
    final String typesOfBoat,
    final String identityNumber,
    final String cnp,
    final bool isAvailable,
    final DateTime create,
    final DateTime rentedAt,
    final DateTime returnedAt,
    final String role,
  );
}
