// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  user_id: json['user_id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  fcm_token: json['fcm_token'] as String,
  is_online: json['is_online'] as bool,
  last_online: DateTime.parse(json['last_online'] as String),
  in_chat: json['in_chat'] as bool,
  profile_url: json['profile_url'] as String,
  cover_url: json['cover_url'] as String,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'name': instance.name,
      'email': instance.email,
      'fcm_token': instance.fcm_token,
      'is_online': instance.is_online,
      'last_online': instance.last_online.toIso8601String(),
      'in_chat': instance.in_chat,
      'profile_url': instance.profile_url,
      'cover_url': instance.cover_url,
    };
