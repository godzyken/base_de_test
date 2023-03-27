import 'package:base_de_test/features/transactions/domain/entities/address/address_entity.dart';
import 'package:base_de_test/features/transactions/domain/entities/address/address_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_list_entity.freezed.dart';
part 'address_list_entity.g.dart';

@freezed
class AddressList with _$AddressList {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AddressList({
    required List<AddressEntity> values,
  }) = _AddressList;

  const AddressList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  AddressList addAddress(final AddressEntity addressEntity) =>
      copyWith(values: [...values, addressEntity]);

  AddressList updateAddress(final AddressEntity newAddress) {
    return copyWith(
        values: values
            .map((addressEntity) =>
                newAddress.id == addressEntity.id ? newAddress : addressEntity)
            .toList());
  }

  AddressList removeAddressById(final AddressId id) => copyWith(
          values: values.where((addressEntity) {
        if (addressEntity.id?.value ==
            addressEntity.copyWith(id: id).id?.value) {
          return true;
        }
        return false;
      }).toList());

  AddressList filterByComplete() => copyWith(
          values: values.where((addressEntity) {
        if (addressEntity.city.isNotEmpty && addressEntity.zipcode.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      }).toList());

  AddressList filterByIncomplete() => copyWith(
          values: values.where((addressEntity) {
        if (addressEntity.city.isEmpty) {
          return true;
        } else {
          return false;
        }
      }).toList());

  factory AddressList.fromJson(Map<String, dynamic> json) =>
      _$AddressListFromJson(json);
}
