// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserEntity _$$_UserEntityFromJson(Map<String, dynamic> json) =>
    _$_UserEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      emailConfirmedAt: json['email_confirmed_at'] == null
          ? null
          : DateTime.parse(json['email_confirmed_at'] as String),
      phoneConfirmedAt: json['phone_confirmed_at'] == null
          ? null
          : DateTime.parse(json['phone_confirmed_at'] as String),
      lastSignInAt: json['last_sign_in_at'] == null
          ? null
          : DateTime.parse(json['last_sign_in_at'] as String),
      role: json['role'] as String?,
    );

Map<String, dynamic> _$$_UserEntityToJson(_$_UserEntity instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'email': instance.email,
    'phone': instance.phone,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  writeNotNull(
      'email_confirmed_at', instance.emailConfirmedAt?.toIso8601String());
  writeNotNull(
      'phone_confirmed_at', instance.phoneConfirmedAt?.toIso8601String());
  writeNotNull('last_sign_in_at', instance.lastSignInAt?.toIso8601String());
  val['role'] = instance.role;
  return val;
}
