import 'package:diconnection/src/data/models/member_model/member_model.dart';
import 'package:diconnection/src/data/models/team_model/team_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'consumer_model.freezed.dart';
part 'consumer_model.g.dart';

@freezed
class ConsumerModel with _$ConsumerModel {
  const factory ConsumerModel(
      {required String? disconnectionId,
      required String? accountNo,
      required String? prevAccountNo,
      required String? consumerName,
      required String? address,
      required String? meterNo,
      required String? billAmount,
      required int? noOfMonths,
      required int? lastReading,
      required int? currentReading,
      required String? remarks,
      required DateTime? disconnectionDate,
      required DateTime? disconnectedDate,
      required String? proofOfDisconnection,
      required int? zoneNo,
      required int? bookNo,
      required bool? isConnected,
      required bool? isPayed,
      required int? status,
      required Team? disconnectionTeam}) = _ConsumerModel;

  factory ConsumerModel.fromJson(Map<String, dynamic> json) =>
      _$ConsumerModelFromJson(json);
}
