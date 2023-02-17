import 'package:base_de_test/features/transactions/domain/entities/boat_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'boat_entity.freezed.dart';
part 'boat_entity.g.dart';

@freezed
class Boat with _$Boat {
  const factory Boat({
    required BoatId? boatId,
    required String name,
    required OwnerEntity ownerEntity,
    required TypesOfBoat types,
    required IdentityNumber identityNumber,
    required CategoriesCNP cnp,
    required bool isAvailable,
    @JsonKey(includeIfNull: false) DateTime? rentedAt,
    @JsonKey(includeIfNull: false) DateTime? returnedAt,
    String? role,
  }) = _Boat;

  const Boat._();

  Boat available() => copyWith(isAvailable: true);
  Boat unavailable() => copyWith(isAvailable: false);

  factory Boat.fromJson(Map<String, dynamic> json) => _$BoatFromJson(json);
}

@freezed
class OwnerEntity with _$OwnerEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OwnerEntity({
    required int id,
    required String name,
    required String phone,
    required Address? address,
  }) = _OwnerEntity;

  factory OwnerEntity.fromJson(Map<String, dynamic> json) =>
      _$OwnerEntityFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    @Default('') String street,
    @Default('') String suite,
    @Default('') String city,
    @Default('') String zipcode,
    Geo? geo,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class Geo with _$Geo {
  const factory Geo({
    @Default(0.0) double lat,
    @Default(0.0) double lng,
  }) = _Geo;

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
}

enum TypesOfBoat { sailingShips, motorShips, watercraft }

enum IdentityNumber { cin, hin, win }

enum CategoriesCNP { a, b, c, d }
