import 'package:base_de_test/features/transactions/application/datasource/database/source_base.dart';
import 'package:base_de_test/features/transactions/application/datasource/mapper/boat_list_mapper.dart';
import 'package:base_de_test/features/transactions/application/datasource/mapper/boat_mapper.dart';
import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:base_de_test/features/transactions/domain/repositories/boats_repository.dart';

class BoatsRepositoryImpl implements BoatsRepository {
  final SourceBase database;

  const BoatsRepositoryImpl(this.database);

  @override
  Future<Boat> createBoat(
      final String name,
      final OwnerId ownerId,
      final OwnerEntity owner,
      final AddressId addressId,
      final AddressEntity address,
      final TypesOfBoat types,
      final IdentityNumber identityNumber,
      final CategoriesCNP cnp,
      final bool isAvailable,
      final DateTime createdAt,
      final DateTime? deletedAt,
      final DateTime? rentedAt,
      final DateTime? returnedAt,
      final String? role) async {
    final boatEntity =
        await database.insertBoat(BoatMapper.transformToNewEntityMap(
      name,
      ownerId,
      owner,
      addressId,
      address,
      cnp,
      identityNumber,
      isAvailable,
      createdAt,
      deletedAt!,
      rentedAt!,
      returnedAt!,
      types,
      role!,
    ));

    return BoatMapper.transformToModel(boatEntity);
  }

  @override
  Future<void> deleteBoat(final BoatId id) async {
    await database.deleteBoat(id.value);
  }

  @override
  Future<BoatList> getBoatList() async {
    final boatListEntity = await database.allBoats();
    return BoatListMapper.transformToModel(boatListEntity);
  }

  @override
  Future<void> updateBoat(
      final BoatId id,
      final String name,
      final OwnerId ownerId,
      final OwnerEntity owner,
      final AddressId addressId,
      final AddressEntity address,
      final TypesOfBoat types,
      final IdentityNumber identityNumber,
      final CategoriesCNP cnp,
      final bool isAvailable,
      final DateTime createdAt,
      final DateTime? deletedAt,
      final DateTime? rentedAt,
      final DateTime? returnedAt,
      final String? role) async {
    final boat = Boat(
      boatId: id,
      name: name,
      ownerEntity: owner,
      addressId: addressId,
      addressEntity: address,
      types: types,
      identityNumber: identityNumber,
      cnp: cnp,
      isAvailable: isAvailable,
      createdAt: createdAt,
      deletedAt: deletedAt!,
      rentedAt: rentedAt!,
      returnedAt: returnedAt!,
      role: role,
      ownerId: ownerId,
    );

    await database.updateBoat(BoatMapper.transformToMap(boat));
  }

  @override
  Stream<List<BoatList>> streamAllBoats() {
    // TODO: implement streamAllBoats
    throw UnimplementedError();
  }

  @override
  Future<void> closeDatabase() async {
    await database.close();
  }
}
