import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_id.freezed.dart';
part 'address_id.g.dart';

@freezed
class AddressId with _$AddressId {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AddressId({
    required int value,
  }) = _AddressId;

  factory AddressId.fromJson(Map<String, dynamic> json) =>
      _$AddressIdFromJson(json);
}
