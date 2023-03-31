import 'package:base_de_test/features/transactions/application/datasource/database/source_base.dart';
import 'package:base_de_test/features/transactions/application/datasource/mapper/address_list_mapper.dart';
import 'package:base_de_test/features/transactions/application/datasource/mapper/address_mapper.dart';
import 'package:base_de_test/features/transactions/domain/entities/address/address_entity.dart';
import 'package:base_de_test/features/transactions/domain/entities/address/address_id.dart';
import 'package:base_de_test/features/transactions/domain/entities/address/address_list_entity.dart';
import 'package:base_de_test/features/transactions/domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final SourceBase database;

  const AddressRepositoryImpl(this.database);

  @override
  Future<AddressEntity> createAddress(String docking, String city,
      String zipcode, String? geo, bool isValid) async {
    final addressEntity = await database.insertAddress(
        AddressMapper.transformToNewEntityMap(
            city, zipcode, docking, geo!, isValid));

    return AddressMapper.transformToModel(addressEntity);
  }

  @override
  Future<int> deleteAddress(AddressId id) async {
    return await database.deleteAddress(id.value);
  }

  @override
  Future<AddressList> getAddressList() async {
    final addressListEntity = await database.allAddress();
    return AddressListMapper.transformToModel(addressListEntity);
  }

  @override
  Future<void> updateAddress(AddressId id, String docking, String city,
      String zipcode, String geo, bool isValid) async {
    final address = AddressEntity(
        id: id,
        docking: docking,
        city: city,
        zipcode: zipcode,
        geo: geo,
        isValid: isValid);

    await database.updateAddress(AddressMapper.transformToMap(address));
  }

  @override
  Stream<List<AddressList>> streamAllAddress() {
    // TODO: implement streamAllAddress
    throw UnimplementedError();
  }
}
