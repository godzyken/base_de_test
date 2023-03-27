import 'package:base_de_test/features/transactions/application/datasource/entity/boats_entity.dart';

abstract class SourceBase {
  Future<BoatListEntity> allBoats();
  Future<OwnerListEntity> allOwners();
  Future<AddressListEntity> allAddress();
  Future<BoatEntity> insertBoat(final BoatEntity boatEntity);
  Future<OwnerEntity> insertOwner(final OwnerEntity ownerEntity);
  Future<AddressEntity> insertAddress(final AddressEntity addressEntity);
  Future<void> updateBoat(final BoatEntity boatEntity);
  Future<void> updateOwner(final OwnerEntity ownerEntity);
  Future<void> updateAddress(final AddressEntity addressEntity);
  Future<int> deleteBoat(final int id);
  Future<int> deleteOwner(final int id);
  Future<int> deleteAddress(final int id);
  Future<int> deleteAllBoat();
  Future close();
}
