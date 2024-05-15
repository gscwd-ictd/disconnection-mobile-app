import 'package:freezed_annotation/freezed_annotation.dart';

part 'viewLedger_model.g.dart';
part 'viewLedger_model.freezed.dart';

@freezed
class ViewLedger with _$ViewLedger{
    const factory ViewLedger({
        required String? accountNo,
        required DateTime? disconnectionDate,
        required String? refNo,
        required DateTime? billDate,
        required DateTime? refDate,
        required DateTime? dueDate,
        required String? ledgerCode,
        required int? prevReading,
        required int? presReading,
        required int? usage,
        required double? debit,
        required double? credit,
        required String? chargeCode,
        required DateTime? timestamp,
        required String? collectorId,
        required String? particulars,
        required String? consumerName,
        required String? address,
        required String? consumerType,
        required bool? isConnected,
        required bool? isReconnected,
        required int? zoneCode,
        required int? bookCode,
        required String? meterNo,
        required String? preparedBy,
        required String? seqNo,
        required bool? isWriteoff,
        required DateTime? dateWriteoff,
        required String? mobileNo,
        required String? telephoneNo,
        required String? checkDigit,
        required String? meterCode,
    }) = _ViewLedger;

    factory ViewLedger.fromJson(Map<String, dynamic> json) => _$ViewLedgerFromJson(json);
}
