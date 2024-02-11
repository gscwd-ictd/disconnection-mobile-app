// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proof_of_disconnection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProofOfDisconnectionImpl _$$ProofOfDisconnectionImplFromJson(
        Map<String, dynamic> json) =>
    _$ProofOfDisconnectionImpl(
      id: json['id'] as String?,
      fileName: json['fileName'] as String?,
      timestamptz: json['timestamptz'] as String?,
      disconnectionId: json['disconnectionId'] as String?,
      teamId: json['teamId'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
    );

Map<String, dynamic> _$$ProofOfDisconnectionImplToJson(
        _$ProofOfDisconnectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'timestamptz': instance.timestamptz,
      'disconnectionId': instance.disconnectionId,
      'teamId': instance.teamId,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
