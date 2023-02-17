import 'package:base_de_test/features/transactions/application/datasource/database/source_base.dart';
import 'package:base_de_test/features/transactions/application/datasource/mapper/boat_list_mapper.dart';
import 'package:base_de_test/features/transactions/application/datasource/mapper/boat_mapper.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat_entity.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat_id.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat_list_entity.dart';
import 'package:base_de_test/features/transactions/domain/repositories/boats_repository.dart';

class BoatsRepositoryImpl implements BoatsRepository {
  final SourceBase database;

  const BoatsRepositoryImpl(this.database);

  @override
  Future<Boat> createBoat(
      final String name,
      final OwnerEntity owner,
      final TypesOfBoat types,
      final IdentityNumber identityNumber,
      final CategoriesCNP cnp,
      final bool isAvailable,
      final DateTime? createdAt,
      final String? role) async {
    final boatEntity = await database.insertBoat(
        BoatMapper.transformToNewEntityMap(name, owner, cnp, identityNumber,
            isAvailable, createdAt!, types, role!));
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
      final OwnerEntity owner,
      final TypesOfBoat types,
      final IdentityNumber identityNumber,
      final CategoriesCNP cnp,
      final bool isAvailable,
      final DateTime? createdAt,
      final DateTime? removedAt,
      final String? role) async {
    final boat = Boat(
        boatId: id,
        name: name,
        ownerEntity: owner,
        types: types,
        identityNumber: identityNumber,
        cnp: cnp,
        isAvailable: isAvailable,
        rentedAt: createdAt,
        returnedAt: removedAt,
        role: role);

    await database.updateBoat(BoatMapper.transformToMap(boat));
  }
}