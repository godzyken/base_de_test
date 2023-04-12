import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner_list_entity.freezed.dart';
part 'owner_list_entity.g.dart';

@freezed
class OwnerList with _$OwnerList {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory OwnerList({
    required List<OwnerEntity> values,
  }) = _OwnerList;

  const OwnerList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  OwnerList addOwner(final OwnerEntity ownerEntity) =>
      copyWith(values: [...values, ownerEntity]);

  OwnerList updateOwner(final OwnerEntity newOwner) {
    return copyWith(
        values: values
            .map((ownerEntity) => newOwner.ownerId == ownerEntity.ownerId
                ? newOwner
                : ownerEntity)
            .toList());
  }

  OwnerList removeOwnerById(final OwnerId id) => copyWith(
          values: values.where((ownerEntity) {
        if (ownerEntity.ownerId.value ==
            ownerEntity.copyWith(ownerId: id).ownerId.value) {
          return true;
        } else {
          return false;
        }
      }).toList());

  OwnerList filterByComplete() => copyWith(
          values: values.where((ownerEntity) {
        if (ownerEntity.phone.isNotEmpty && ownerEntity.name.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      }).toList());

  OwnerList filterByIncomplete() => copyWith(
          values: values.where((ownerEntity) {
        if (ownerEntity.phone.isEmpty) {
          return true;
        } else {
          return false;
        }
      }).toList());

  OwnerList filterById(int id) => copyWith(
          values: values.where((boat) {
        if (boat.ownerId.value == id) {
          return boat.isValid;
        } else {
          return false;
        }
      }).toList());

  factory OwnerList.fromJson(Map<String, dynamic> json) =>
      _$OwnerListFromJson(json);
}
