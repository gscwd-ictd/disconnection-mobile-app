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
      billAmount: json['billAmount'] as String?,
      noOfMonths: (json['noOfMonths'] as num?)?.toInt(),
      lastReading: (json['lastReading'] as num?)?.toInt(),
      currentReading: (json['currentReading'] as num?)?.toInt(),
      remarks: json['remarks'] as String?,
      disconnectionDate: json['disconnectionDate'] == null
          ? null
          : DateTime.parse(json['disconnectionDate'] as String),
      disconnectedDate: json['disconnectedDate'] == null
          ? null
          : DateTime.parse(json['disconnectedDate'] as String),
      disconnectedTime: json['disconnectedTime'] as String?,
      zoneNo: (json['zoneNo'] as num?)?.toInt(),
      bookNo: (json['bookNo'] as num?)?.toInt(),
      isConnected: json['isConnected'] as bool?,
      isPayed: json['isPayed'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      seqNo: (json['seqNo'] as num?)?.toInt(),
      jobCode: (json['jobCode'] as num?)?.toInt(),
      disconnectionTeam: json['disconnectionTeam'] == null
          ? null
          : Team.fromJson(json['disconnectionTeam'] as Map<String, dynamic>),
      dispatchDateTime: json['dispatchDateTime'] == null
          ? null
          : DateTime.parse(json['dispatchDateTime'] as String),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      proofOfDisconnection: (json['proofOfDisconnection'] as List<dynamic>?)
          ?.map((e) => ProofOfDisconnection.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'disconnectedTime': instance.disconnectedTime,
      'zoneNo': instance.zoneNo,
      'bookNo': instance.bookNo,
      'isConnected': instance.isConnected,
      'isPayed': instance.isPayed,
      'status': instance.status,
      'seqNo': instance.seqNo,
      'jobCode': instance.jobCode,
      'disconnectionTeam': instance.disconnectionTeam,
      'dispatchDateTime': instance.dispatchDateTime?.toIso8601String(),
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'proofOfDisconnection': instance.proofOfDisconnection,
    };
