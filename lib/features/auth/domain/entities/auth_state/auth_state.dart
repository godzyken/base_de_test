import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

@freezed
class AuthState with _$AuthState {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory AuthState.authenticated({
    @JsonKey(
      defaultValue: 'AuthStatus',
      includeFromJson: false,
      includeToJson: false,
    )
        AuthStatus? status,
    @JsonKey(
      defaultValue: 'AuthUser',
      includeToJson: false,
      includeFromJson: false,
    )
        AuthUser? user,
  }) = _AuthStateTrue;

  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory AuthState.unauthenticated({
    @JsonKey(
      defaultValue: 'AuthStatus',
      includeFromJson: false,
      includeToJson: false,
    )
        AuthStatus? status,
  }) = _AuthStateFalse;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
