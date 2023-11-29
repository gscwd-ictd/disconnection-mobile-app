// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumerModelImpl _$$ConsumerModelImplFromJson(Map<String, dynamic> json) =>
    _$ConsumerModelImpl(
      disconnectionId: json['disconnectionId'] as String?,
      accountNo: json['accountNo'] as String?,
      prevAccountNo: json['prevAccountNo'] as String?,
      consumerName: json['consumerName'] as String?,
      address: json['address'] as String?,
      meterNo: json['meterNo'] as String?,
      billAmount: (json['billAmount'] as num?)?.toDouble(),
      noOfMonths: json['noOfMonths'] as int?,
      lastReading: json['lastReading'] as int?,
      currentReading: json['currentReading'] as int?,
      remarks: json['remarks'] as String?,
      disconnectionDate: json['disconnectionDate'] == null
          ? null
          : DateTime.parse(json['disconnectionDate'] as String),
      disconnectedDate: json['disconnectedDate'] == null
          ? null
          : DateTime.parse(json['disconnectedDate'] as String),
      proofOfDisconnection: json['proofOfDisconnection'] as String?,
      zoneNo: json['zoneNo'] as int?,
      bookNo: json['bookNo'] as int?,
      isConnected: json['isConnected'] as bool?,
      isPayed: json['isPayed'] as bool?,
      disconnectionTeam: json['disconnectionTeam'] == null
          ? null
          : Team.fromJson(json['disconnectionTeam'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ConsumerModelImplToJson(_$ConsumerModelImpl instance) =>
    <String, dynamic>{
      'disconnectionId': instance.disconnectionId,
      'accountNo': instance.accountNo,
      'prevAccountNo': instance.prevAccountNo,
      'consumerName': instance.consumerName,
      'address': instance.address,
      'meterNo': instance.meterNo,
      'billAmount': instance.billAmount,
      'noOfMonths': instance.noOfMonths,
      'lastReading': instance.lastReading,
      'currentReading': instance.currentReading,
      'remarks': instance.remarks,
      'disconnectionDate': instance.disconnectionDate?.toIso8601String(),
      'disconnectedDate': instance.disconnectedDate?.toIso8601String(),
      'proofOfDisconnection': instance.proofOfDisconnection,
      'zoneNo': instance.zoneNo,
      'bookNo': instance.bookNo,
      'isConnected': instance.isConnected,
      'isPayed': instance.isPayed,
      'disconnectionTeam': instance.disconnectionTeam,
    };
