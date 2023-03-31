import 'package:freezed_annotation/freezed_annotation.dart';

import 'address_id.dart';

part 'address_entity.freezed.dart';
part 'address_entity.g.dart';

@freezed
class AddressEntity with _$AddressEntity {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AddressEntity({
    required AddressId? id,
    @Default('Docking.anchoring') String docking,
    @Default('') String city,
    @Default('') String zipcode,
    String? geo,
    @Default(false) bool isValid,
  }) = _AddressEntity;

  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);

  factory AddressEntity.empty() => const AddressEntity(
      id: AddressId(value: 0),
      docking: '',
      zipcode: '',
      city: '',
      geo: '',
      isValid: false);
}

@JsonEnum()
enum Docking {
  @JsonValue("harbor")
  harbor,
  @JsonValue("couple")
  couple,
  @JsonValue("marinas")
  marinas,
  @JsonValue("anchoring")
  anchoring
}

@freezed
class GeoEntity with _$GeoEntity {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory GeoEntity({
    @Default(0.0) double lat,
    @Default(0.0) double lng,
  }) = _GeoEntity;

  factory GeoEntity.fromJson(Map<String, dynamic> json) =>
      _$GeoEntityFromJson(json);
}
