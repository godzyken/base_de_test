import 'package:freezed_annotation/freezed_annotation.dart';

part 'boat_id.freezed.dart';
part 'boat_id.g.dart';

@freezed
class BoatId with _$BoatId {
  const factory BoatId({required int value}) = _BoatId;
  factory BoatId.fromJson(Map<String, dynamic> json) => _$BoatIdFromJson(json);
}
