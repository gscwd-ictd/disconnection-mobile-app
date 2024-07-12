import 'package:diconnection/src/data/models/member_model/member_model.dart';
import 'package:diconnection/src/data/models/proof_of_disconnection_model/proof_of_disconnection_hive_model.dart';
import 'package:diconnection/src/data/models/proof_of_disconnection_model/proof_of_disconnection_model.dart';
import 'package:diconnection/src/data/models/team_model/team_hive_model.dart';
import 'package:diconnection/src/data/models/team_model/team_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'consumer_hive_model.g.dart';

@HiveType(typeId: 2)
class ConsumerHive {
  @HiveField(6)
  final String? disconnectionId;

  @HiveField(7)
  final String? accountNo;

  @HiveField(8)
  final String? prevAccountNo;

  @HiveField(9)
  final String? consumerName;

  @HiveField(10)
  final String? address;

  @HiveField(11)
  final String? meterNo;

  @HiveField(12)
  final String? billAmount;

  @HiveField(13)
  final int? noOfMonths;

  @HiveField(14)
  final int? lastReading;

  @HiveField(15)
  final int? currentReading;

  @HiveField(16)
  final String? remarks;

  @HiveField(17)
  final DateTime? disconnectionDate;

  @HiveField(18)
  final DateTime? disconnectedDate;

  @HiveField(19)
  final String? disconnectedTime;

  @HiveField(20)
  final int? zoneNo;

  @HiveField(21)
  final int? bookNo;

  @HiveField(22)
  final bool? isConnected;

  @HiveField(23)
  final bool? isPayed;

  @HiveField(24)
  final int? status;

  @HiveField(25)
  final int? seqNo;

  @HiveField(26)
  final TeamHive? disconnectionTeam;

  @HiveField(27)
  final List<ProofOfDisconnectionHive>? proofOfDisconnection;

  @HiveField(44)
  final int? jobCode;

  @HiveField(45)
  final DateTime? dispatchDateTime;

  @HiveField(46)
  final DateTime? lastUpdated;

  ConsumerHive(
      {this.disconnectionId,
      this.accountNo,
      this.prevAccountNo,
      this.consumerName,
      this.address,
      this.meterNo,
      this.billAmount,
      this.noOfMonths,
      this.lastReading,
      this.currentReading,
      this.remarks,
      this.disconnectionDate,
      this.disconnectedDate,
      this.disconnectedTime,
      this.zoneNo,
      this.bookNo,
      this.isConnected,
      this.isPayed,
      this.status,
      this.seqNo,
      this.disconnectionTeam,
      this.proofOfDisconnection,
      this.jobCode,
      this.dispatchDateTime,
      this.lastUpdated});
}
