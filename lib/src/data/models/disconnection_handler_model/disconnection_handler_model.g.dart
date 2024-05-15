// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disconnection_handler_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DisconnectionHandlerImpl _$$DisconnectionHandlerImplFromJson(
        Map<String, dynamic> json) =>
    _$DisconnectionHandlerImpl(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ConsumerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      zoneList: (json['zoneList'] as List<dynamic>?)
          ?.map((e) => LibZones.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DisconnectionHandlerImplToJson(
        _$DisconnectionHandlerImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'zoneList': instance.zoneList,
    };
