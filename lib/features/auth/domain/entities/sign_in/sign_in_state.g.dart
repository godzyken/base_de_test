// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SignInState _$$_SignInStateFromJson(Map<String, dynamic> json) =>
    _$_SignInState(
      status: $enumDecodeNullable(_$FormzStatusEnumMap, json['status']) ??
          FormzStatus.pure,
      errorMessage: json['error_message'] as String?,
    );

Map<String, dynamic> _$$_SignInStateToJson(_$_SignInState instance) =>
    <String, dynamic>{
      'status': _$FormzStatusEnumMap[instance.status],
      'error_message': instance.errorMessage,
    };

const _$FormzStatusEnumMap = {
  FormzStatus.pure: 'pure',
  FormzStatus.valid: 'valid',
  FormzStatus.invalid: 'invalid',
  FormzStatus.submissionInProgress: 'submissionInProgress',
  FormzStatus.submissionSuccess: 'submissionSuccess',
  FormzStatus.submissionFailure: 'submissionFailure',
  FormzStatus.submissionCanceled: 'submissionCanceled',
};
