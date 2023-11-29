// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamImpl _$$TeamImplFromJson(Map<String, dynamic> json) => _$TeamImpl(
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String?,
      teamLeader: json['teamLeader'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamLeader': instance.teamLeader,
      'status': instance.status,
    };
