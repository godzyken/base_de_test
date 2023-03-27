import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities.dart';

part 'owner_entity.freezed.dart';
part 'owner_entity.g.dart';

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

  factory OwnerEntity.empty() => const OwnerEntity(
      ownerId: OwnerId(value: 0), name: '', phone: '', isValid: false ?? true);
}
