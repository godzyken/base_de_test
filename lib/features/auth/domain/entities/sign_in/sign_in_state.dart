import 'package:base_de_test/features/auth/domain/entities/user_properties/email.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../user_properties/password.dart';

part 'sign_in_state.freezed.dart';
part 'sign_in_state.g.dart';

@freezed
class SignInState with _$SignInState {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory SignInState({
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
    @Default(FormzSubmissionStatus.initial)
        FormzSubmissionStatus? status,
    String? errorMessage,
  }) = _SignInState;

  factory SignInState.fromJson(Map<String, dynamic> json) =>
      _$SignInStateFromJson(json);
}
