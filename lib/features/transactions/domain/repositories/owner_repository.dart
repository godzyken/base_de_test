import 'package:base_de_test/features/transactions/domain/entities/entities.dart';

abstract class OwnerRepository {
  Future<OwnerEntity> createOwner(final String name, final String phone);
  Future<void> updateOwner(
      final OwnerId id, final String name, final String phone);
  Future<int> deleteOwner(final OwnerId id);
}
