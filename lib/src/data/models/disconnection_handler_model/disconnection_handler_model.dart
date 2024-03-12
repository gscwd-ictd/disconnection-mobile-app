import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/data/models/lib_zones_model/lib_zones_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'disconnection_handler_model.freezed.dart';
part 'disconnection_handler_model.g.dart';

@freezed
class DisconnectionHandler with _$DisconnectionHandler {
  const factory DisconnectionHandler(
      {required List<ConsumerModel>? items,
      required List<LibZones>? zoneList}) = _DisconnectionHandler;

  factory DisconnectionHandler.fromJson(Map<String, dynamic> json) =>
      _$DisconnectionHandlerFromJson(json);
}
