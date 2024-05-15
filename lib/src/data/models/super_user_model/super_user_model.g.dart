// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SuperUserImpl _$$SuperUserImplFromJson(Map<String, dynamic> json) =>
    _$SuperUserImpl(
      userId: json['userId'] as String?,
      username: json['username'] as String?,
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$$SuperUserImplToJson(_$SuperUserImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'team': instance.team,
      'accessToken': instance.accessToken,
    };
