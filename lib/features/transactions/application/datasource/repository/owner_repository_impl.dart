import 'package:base_de_test/features/transactions/application/datasource/database/source_base.dart';
import 'package:base_de_test/features/transactions/application/datasource/mapper/owner_mapper.dart';
import 'package:base_de_test/features/transactions/domain/entities/owner/owner_entity.dart';
import 'package:base_de_test/features/transactions/domain/entities/owner/owner_id.dart';
import 'package:base_de_test/features/transactions/domain/entities/owner/owner_list_entity.dart';
import 'package:base_de_test/features/transactions/domain/repositories/owner_repository.dart';

import '../mapper/owner_list_mapper.dart';

class OwnerRepositoryImpl implements OwnerRepository {
  final SourceBase database;

  const OwnerRepositoryImpl(this.database);

  @override
  Future<OwnerEntity> createOwner(
      String name, String phone, bool isValid) async {
    final ownerEntity = await database
        .insertOwner(OwnerMapper.transformToNewEntityMap(name, phone, isValid));

    return OwnerMapper.transformToModel(ownerEntity);
  }

  @override
  Future<int> deleteOwner(OwnerId id) async {
    return await database.deleteOwner(id.value);
  }

  @override
  Future<void> updateOwner(
      OwnerId id, String name, String phone, bool isValid) async {
    final owner =
        OwnerEntity(ownerId: id, name: name, phone: phone, isValid: isValid);

    await database.updateOwner(OwnerMapper.transformToMap(owner));
  }

  @override
  Future<OwnerList> getOwnerList() async {
    final ownerListEntity = await database.allOwners();
    return OwnerListMapper.transformToModel(ownerListEntity);
  }

  @override
  Future<void> closeDatabase() async {
    await database.close();
  }
}
