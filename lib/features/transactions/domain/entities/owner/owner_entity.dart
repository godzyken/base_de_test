import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

part 'owner_entity.freezed.dart';
part 'owner_entity.g.dart';

var _uuid = const Uuid();

@freezed
class OwnerEntity with _$OwnerEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OwnerEntity(
      {required OwnerId ownerId,
      required String name,
      required String phone,
      @Default(false) bool isValid}) = _OwnerEntity;

  const OwnerEntity._();

  OwnerEntity available() => copyWith(isValid: true);
  OwnerEntity unavailable() => copyWith(isValid: false);

  factory OwnerEntity.fromJson(Map<String, dynamic> json) =>
      _$OwnerEntityFromJson(json);

  factory OwnerEntity.create(String name, String phone) {
    return OwnerEntity(
        ownerId: OwnerId(value: int.parse(_uuid.v4())),
        name: name,
        phone: phone);
  }

  factory OwnerEntity.empty() => const OwnerEntity(
      ownerId: OwnerId(value: 0), name: '', phone: '', isValid: false ?? true);
}
