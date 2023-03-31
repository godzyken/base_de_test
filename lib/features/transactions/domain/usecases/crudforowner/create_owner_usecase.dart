import '../../entities/entities.dart';

abstract class CreateOwnerEntityCase {
  Future<OwnerEntity> execute(
    final String name,
    final String phone,
    final bool isValid,
  );
}
