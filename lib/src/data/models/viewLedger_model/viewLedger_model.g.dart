// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewLedger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ViewLedgerImpl _$$ViewLedgerImplFromJson(Map<String, dynamic> json) =>
    _$ViewLedgerImpl(
      accountNo: json['accountNo'] as String?,
      disconnectionDate: json['disconnectionDate'] == null
          ? null
          : DateTime.parse(json['disconnectionDate'] as String),
      refNo: json['refNo'] as String?,
      billDate: json['billDate'] == null
          ? null
          : DateTime.parse(json['billDate'] as String),
      refDate: json['refDate'] == null
          ? null
          : DateTime.parse(json['refDate'] as String),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      ledgerCode: json['ledgerCode'] as String?,
      prevReading: json['prevReading'] as int?,
      presReading: json['presReading'] as int?,
      usage: json['usage'] as int?,
      debit: (json['debit'] as num?)?.toDouble(),
      credit: (json['credit'] as num?)?.toDouble(),
      chargeCode: json['chargeCode'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      collectorId: json['collectorId'] as String?,
      particulars: json['particulars'] as String?,
      consumerName: json['consumerName'] as String?,
      address: json['address'] as String?,
      consumerType: json['consumerType'] as String?,
      isConnected: json['isConnected'] as bool?,
      isReconnected: json['isReconnected'] as bool?,
      zoneCode: json['zoneCode'] as int?,
      bookCode: json['bookCode'] as int?,
      meterNo: json['meterNo'] as String?,
      preparedBy: json['preparedBy'] as String?,
      seqNo: json['seqNo'] as String?,
      isWriteoff: json['isWriteoff'] as bool?,
      dateWriteoff: json['dateWriteoff'] == null
          ? null
          : DateTime.parse(json['dateWriteoff'] as String),
      mobileNo: json['mobileNo'] as String?,
      telephoneNo: json['telephoneNo'] as String?,
      checkDigit: json['checkDigit'] as String?,
      meterCode: json['meterCode'] as String?,
    );

Map<String, dynamic> _$$ViewLedgerImplToJson(_$ViewLedgerImpl instance) =>
    <String, dynamic>{
      'accountNo': instance.accountNo,
      'disconnectionDate': instance.disconnectionDate?.toIso8601String(),
      'refNo': instance.refNo,
      'billDate': instance.billDate?.toIso8601String(),
      'refDate': instance.refDate?.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'ledgerCode': instance.ledgerCode,
      'prevReading': instance.prevReading,
      'presReading': instance.presReading,
      'usage': instance.usage,
      'debit': instance.debit,
      'credit': instance.credit,
      'chargeCode': instance.chargeCode,
      'timestamp': instance.timestamp?.toIso8601String(),
      'collectorId': instance.collectorId,
      'particulars': instance.particulars,
      'consumerName': instance.consumerName,
      'address': instance.address,
      'consumerType': instance.consumerType,
      'isConnected': instance.isConnected,
      'isReconnected': instance.isReconnected,
      'zoneCode': instance.zoneCode,
      'bookCode': instance.bookCode,
      'meterNo': instance.meterNo,
      'preparedBy': instance.preparedBy,
      'seqNo': instance.seqNo,
      'isWriteoff': instance.isWriteoff,
      'dateWriteoff': instance.dateWriteoff?.toIso8601String(),
      'mobileNo': instance.mobileNo,
      'telephoneNo': instance.telephoneNo,
      'checkDigit': instance.checkDigit,
      'meterCode': instance.meterCode,
    };
