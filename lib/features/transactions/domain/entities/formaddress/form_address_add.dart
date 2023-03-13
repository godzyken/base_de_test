import 'package:base_de_test/features/transactions/domain/entities/address_properties/street.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_address_add.freezed.dart';
part 'form_address_add.g.dart';

@freezed
class FormAddressAddState with _$FormAddressAddState {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory FormAddressAddState({
    @JsonKey(
      defaultValue: 'Street name',
      includeToJson: false,
      includeFromJson: false,
    )
        StreetNameFormz? streetNameFormz,
    @JsonKey(
      defaultValue: 'Suite name',
      includeToJson: false,
      includeFromJson: false,
    )
        SuiteNameFormz? suiteNameFormz,
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
