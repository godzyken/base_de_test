import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_owner_add.freezed.dart';
part 'form_owner_add.g.dart';

@freezed
class FormOwnerAddState with _$FormOwnerAddState {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory FormOwnerAddState({
    @JsonKey(
      defaultValue: 'OwnerName',
      includeToJson: false,
      includeFromJson: false,
    )
        OwnerNameFormz? ownerNameFormz,
    @JsonKey(
      defaultValue: 'OwnerPhone',
      includeToJson: false,
      includeFromJson: false,
    )
        OwnerPhoneFormz? ownerPhoneFormz,
    @Default(FormzSubmissionStatus.initial)
        FormzSubmissionStatus? status,
  }) = _FormOwnerAddState;

  factory FormOwnerAddState.fromJson(Map<String, dynamic> json) =>
      _$FormOwnerAddStateFromJson(json);
}
