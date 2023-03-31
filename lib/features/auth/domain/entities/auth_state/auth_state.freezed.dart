// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthState _$AuthStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'authenticated':
      return _AuthStateTrue.fromJson(json);
    case 'unauthenticated':
      return _AuthStateFalse.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'AuthState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$AuthState {
  @JsonKey(
      defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
  AuthStatus? get status => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
                AuthStatus? status,
            @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
                AuthUser? user)
        authenticated,
    required TResult Function(@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false) AuthStatus? status) unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
                AuthStatus? status,
            @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
                AuthUser? user)?
        authenticated,
    TResult? Function(@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false) AuthStatus? status)? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
                AuthStatus? status,
            @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
                AuthUser? user)?
        authenticated,
    TResult Function(@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false) AuthStatus? status)? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateTrue value) authenticated,
    required TResult Function(_AuthStateFalse value) unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthStateTrue value)? authenticated,
    TResult? Function(_AuthStateFalse value)? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateTrue value)? authenticated,
    TResult Function(_AuthStateFalse value)? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call(
      {@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
          AuthStatus? status});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthStateTrueCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$_AuthStateTrueCopyWith(
          _$_AuthStateTrue value, $Res Function(_$_AuthStateTrue) then) =
      __$$_AuthStateTrueCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
          AuthStatus? status,
      @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
          AuthUser? user});
}

/// @nodoc
class __$$_AuthStateTrueCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthStateTrue>
    implements _$$_AuthStateTrueCopyWith<$Res> {
  __$$_AuthStateTrueCopyWithImpl(
      _$_AuthStateTrue _value, $Res Function(_$_AuthStateTrue) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_AuthStateTrue(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AuthUser?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_AuthStateTrue implements _AuthStateTrue {
  const _$_AuthStateTrue(
      {@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
          this.status,
      @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
          this.user,
      final String? $type})
      : $type = $type ?? 'authenticated';

  factory _$_AuthStateTrue.fromJson(Map<String, dynamic> json) =>
      _$$_AuthStateTrueFromJson(json);

  @override
  @JsonKey(
      defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
  final AuthStatus? status;
  @override
  @JsonKey(
      defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
  final AuthUser? user;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AuthState.authenticated(status: $status, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStateTrue &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthStateTrueCopyWith<_$_AuthStateTrue> get copyWith =>
      __$$_AuthStateTrueCopyWithImpl<_$_AuthStateTrue>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
                AuthStatus? status,
            @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
                AuthUser? user)
        authenticated,
    required TResult Function(@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false) AuthStatus? status) unauthenticated,
  }) {
    return authenticated(status, user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
                AuthStatus? status,
            @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
                AuthUser? user)?
        authenticated,
    TResult? Function(@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false) AuthStatus? status)? unauthenticated,
  }) {
    return authenticated?.call(status, user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
                AuthStatus? status,
            @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
                AuthUser? user)?
        authenticated,
    TResult Function(@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false) AuthStatus? status)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(status, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateTrue value) authenticated,
    required TResult Function(_AuthStateFalse value) unauthenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthStateTrue value)? authenticated,
    TResult? Function(_AuthStateFalse value)? unauthenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateTrue value)? authenticated,
    TResult Function(_AuthStateFalse value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthStateTrueToJson(
      this,
    );
  }
}

abstract class _AuthStateTrue implements AuthState {
  const factory _AuthStateTrue(
      {@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
          final AuthStatus? status,
      @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
          final AuthUser? user}) = _$_AuthStateTrue;

  factory _AuthStateTrue.fromJson(Map<String, dynamic> json) =
      _$_AuthStateTrue.fromJson;

  @override
  @JsonKey(
      defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
  AuthStatus? get status;
  @JsonKey(
      defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
  AuthUser? get user;
  @override
  @JsonKey(ignore: true)
  _$$_AuthStateTrueCopyWith<_$_AuthStateTrue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AuthStateFalseCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$_AuthStateFalseCopyWith(
          _$_AuthStateFalse value, $Res Function(_$_AuthStateFalse) then) =
      __$$_AuthStateFalseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
          AuthStatus? status});
}

/// @nodoc
class __$$_AuthStateFalseCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthStateFalse>
    implements _$$_AuthStateFalseCopyWith<$Res> {
  __$$_AuthStateFalseCopyWithImpl(
      _$_AuthStateFalse _value, $Res Function(_$_AuthStateFalse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_$_AuthStateFalse(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_AuthStateFalse implements _AuthStateFalse {
  const _$_AuthStateFalse(
      {@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
          this.status,
      final String? $type})
      : $type = $type ?? 'unauthenticated';

  factory _$_AuthStateFalse.fromJson(Map<String, dynamic> json) =>
      _$$_AuthStateFalseFromJson(json);

  @override
  @JsonKey(
      defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
  final AuthStatus? status;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AuthState.unauthenticated(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStateFalse &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthStateFalseCopyWith<_$_AuthStateFalse> get copyWith =>
      __$$_AuthStateFalseCopyWithImpl<_$_AuthStateFalse>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
                AuthStatus? status,
            @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
                AuthUser? user)
        authenticated,
    required TResult Function(@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false) AuthStatus? status) unauthenticated,
  }) {
    return unauthenticated(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
                AuthStatus? status,
            @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
                AuthUser? user)?
        authenticated,
    TResult? Function(@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false) AuthStatus? status)? unauthenticated,
  }) {
    return unauthenticated?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
                AuthStatus? status,
            @JsonKey(defaultValue: 'AuthUser', includeToJson: false, includeFromJson: false)
                AuthUser? user)?
        authenticated,
    TResult Function(@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false) AuthStatus? status)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStateTrue value) authenticated,
    required TResult Function(_AuthStateFalse value) unauthenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthStateTrue value)? authenticated,
    TResult? Function(_AuthStateFalse value)? unauthenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStateTrue value)? authenticated,
    TResult Function(_AuthStateFalse value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthStateFalseToJson(
      this,
    );
  }
}

abstract class _AuthStateFalse implements AuthState {
  const factory _AuthStateFalse(
      {@JsonKey(defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
          final AuthStatus? status}) = _$_AuthStateFalse;

  factory _AuthStateFalse.fromJson(Map<String, dynamic> json) =
      _$_AuthStateFalse.fromJson;

  @override
  @JsonKey(
      defaultValue: 'AuthStatus', includeFromJson: false, includeToJson: false)
  AuthStatus? get status;
  @override
  @JsonKey(ignore: true)
  _$$_AuthStateFalseCopyWith<_$_AuthStateFalse> get copyWith =>
      throw _privateConstructorUsedError;
}
