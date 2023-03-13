import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner_id.freezed.dart';
part 'owner_id.g.dart';

@freezed
class OwnerId with _$OwnerId {
  const factory OwnerId({required int value}) = _OwnerId;
  factory OwnerId.fromJson(Map<String, dynamic> json) =>
      _$OwnerIdFromJson(json);
}
