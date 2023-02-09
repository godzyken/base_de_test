import 'package:base_de_test/features/auth/domain/entities/user_properties/name.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../user_properties/email.dart';
import '../user_properties/password.dart';

part 'sign_up_state.freezed.dart';
part 'sign_up_state.g.dart';

@freezed
class SignUpState with _$SignUpState {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory SignUpState({
    @JsonKey(
      defaultValue: 'NameFormz',
      includeToJson: false,
      includeFromJson: false,
    )
        NameFormz? nameFormz,
    @JsonKey(
      defaultValue: 'EmailFormz',
      includeFromJson: false,
      includeToJson: false,
    )
        EmailFormz? emailFormz,
    @JsonKey(
      defaultValue: 'PasswordFormz',
      includeFromJson: false,
      includeToJson: false,
    )
        PasswordFormz? passwordFormz,
    @Default(FormzStatus.pure)
        FormzStatus? status,
    String? errorMessage,
  }) = _SignUpState;

  factory SignUpState.fromJson(Map<String, dynamic> json) =>
      _$SignUpStateFromJson(json);
}
