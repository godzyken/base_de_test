// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SignInState _$$_SignInStateFromJson(Map<String, dynamic> json) =>
    _$_SignInState(
      status:
          $enumDecodeNullable(_$FormzSubmissionStatusEnumMap, json['status']) ??
              FormzSubmissionStatus.initial,
      errorMessage: json['error_message'] as String?,
    );

Map<String, dynamic> _$$_SignInStateToJson(_$_SignInState instance) =>
    <String, dynamic>{
      'status': _$FormzSubmissionStatusEnumMap[instance.status],
      'error_message': instance.errorMessage,
    };

const _$FormzSubmissionStatusEnumMap = {
  FormzSubmissionStatus.initial: 'initial',
  FormzSubmissionStatus.inProgress: 'inProgress',
  FormzSubmissionStatus.success: 'success',
  FormzSubmissionStatus.failure: 'failure',
  FormzSubmissionStatus.canceled: 'canceled',
};
