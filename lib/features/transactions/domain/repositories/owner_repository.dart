import 'package:base_de_test/features/transactions/domain/entities/entities.dart';

abstract class OwnerRepository {
  Future<OwnerList> getOwnerList();
  Future<OwnerEntity> createOwner(
      final String name, final String phone, bool isValid);
  Future<void> updateOwner(final OwnerId id, final String name,
      final String phone, final bool isValid);
  Future<int> deleteOwner(final OwnerId id);
  Future<void> closeDatabase();
}
