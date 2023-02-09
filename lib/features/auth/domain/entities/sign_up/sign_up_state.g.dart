// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SignUpState _$$_SignUpStateFromJson(Map<String, dynamic> json) =>
    _$_SignUpState(
      status: $enumDecodeNullable(_$FormzStatusEnumMap, json['status']) ??
          FormzStatus.pure,
      errorMessage: json['error_message'] as String?,
    );

Map<String, dynamic> _$$_SignUpStateToJson(_$_SignUpState instance) =>
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
