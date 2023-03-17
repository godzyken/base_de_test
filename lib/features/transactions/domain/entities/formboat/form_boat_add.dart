import 'package:base_de_test/features/transactions/domain/entities/boat_properties/boat_name.dart';
import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_boat_add.freezed.dart';
part 'form_boat_add.g.dart';

@freezed
class FormBoatAddState with _$FormBoatAddState {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory FormBoatAddState(
    Boat boat,
    OwnerEntity ownerEntity,
    AddressEntity addressEntity, {
    @JsonKey(
      defaultValue: 'BoatName',
      includeToJson: false,
      includeFromJson: false,
    )
        BoatNameFormz? boatNameFormz,
    @JsonKey(
      defaultValue: 'BoatRole',
      includeToJson: false,
      includeFromJson: false,
    )
        BoatRoleFormz? boatRoleFormz,
    @JsonKey(
      defaultValue: 'FormOwner',
      includeToJson: false,
      includeFromJson: false,
    )
        FormOwnerAddState? formOwnerAddState,
    @JsonKey(
      defaultValue: 'FormAddress',
      includeToJson: false,
      includeFromJson: false,
    )
        FormAddressAddState? formAddressAddState,
    @Default(FormzSubmissionStatus.initial)
        FormzSubmissionStatus? status,
  }) = _FormBoatAddState;

  factory FormBoatAddState.fromJson(Map<String, dynamic> json) =>
      _$FormBoatAddStateFromJson(json);
}
