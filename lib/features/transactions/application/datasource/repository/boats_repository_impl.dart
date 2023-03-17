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
      final AddressId addressId,
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
      addressId,
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
  Future<int> deleteBoat(final BoatId id) async {
    return await database.deleteBoat(id.value);
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
      final AddressId addressId,
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
      addressId: addressId,
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

  @override
  Future<int> deleteAllBoat() async {
    return await database.deleteAllBoat();
  }
}
