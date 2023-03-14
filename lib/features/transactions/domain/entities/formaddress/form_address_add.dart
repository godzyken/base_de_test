import 'package:base_de_test/features/transactions/domain/entities/address_properties/docking.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_address_add.freezed.dart';
part 'form_address_add.g.dart';

@freezed
class FormAddressAddState with _$FormAddressAddState {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory FormAddressAddState({
    @JsonKey(
      defaultValue: 'Docking',
      includeToJson: false,
      includeFromJson: false,
    )
        DockingFormz? dockingFormz,
    @JsonKey(
      defaultValue: 'City name',
      includeToJson: false,
      includeFromJson: false,
    )
        CityNameFormz? cityNameFormz,
    @JsonKey(
      defaultValue: 'Zip code',
      includeToJson: false,
      includeFromJson: false,
    )
        ZipCodeFormz? zipCodeFormz,
    @Default(FormzSubmissionStatus.initial)
        FormzSubmissionStatus? status,
    String? errorMessage,
  }) = _FormAddressAddState;

  factory FormAddressAddState.fromJson(Map<String, dynamic> json) =>
      _$FormAddressAddStateFromJson(json);
}
