// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumer_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsumerHiveAdapter extends TypeAdapter<ConsumerHive> {
  @override
  final int typeId = 2;

  @override
  ConsumerHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsumerHive(
      disconnectionId: fields[6] as String?,
      accountNo: fields[7] as String?,
      prevAccountNo: fields[8] as String?,
      consumerName: fields[9] as String?,
      address: fields[10] as String?,
      meterNo: fields[11] as String?,
      billAmount: fields[12] as String?,
      noOfMonths: fields[13] as int?,
      lastReading: fields[14] as int?,
      currentReading: fields[15] as int?,
      remarks: fields[16] as String?,
      disconnectionDate: fields[17] as DateTime?,
      disconnectedDate: fields[18] as DateTime?,
      disconnectedTime: fields[19] as String?,
      zoneNo: fields[20] as int?,
      bookNo: fields[21] as int?,
      isConnected: fields[22] as bool?,
      isPayed: fields[23] as bool?,
      status: fields[24] as int?,
      seqNo: fields[25] as int?,
      disconnectionTeam: fields[26] as TeamHive?,
      proofOfDisconnection:
          (fields[27] as List?)?.cast<ProofOfDisconnectionHive>(),
      jobCode: fields[44] as int?,
      dispatchDateTime: fields[45] as DateTime?,
      lastUpdated: fields[46] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ConsumerHive obj) {
    writer
      ..writeByte(25)
      ..writeByte(6)
      ..write(obj.disconnectionId)
      ..writeByte(7)
      ..write(obj.accountNo)
      ..writeByte(8)
      ..write(obj.prevAccountNo)
      ..writeByte(9)
      ..write(obj.consumerName)
      ..writeByte(10)
      ..write(obj.address)
      ..writeByte(11)
      ..write(obj.meterNo)
      ..writeByte(12)
      ..write(obj.billAmount)
      ..writeByte(13)
      ..write(obj.noOfMonths)
      ..writeByte(14)
      ..write(obj.lastReading)
      ..writeByte(15)
      ..write(obj.currentReading)
      ..writeByte(16)
      ..write(obj.remarks)
      ..writeByte(17)
      ..write(obj.disconnectionDate)
      ..writeByte(18)
      ..write(obj.disconnectedDate)
      ..writeByte(19)
      ..write(obj.disconnectedTime)
      ..writeByte(20)
      ..write(obj.zoneNo)
      ..writeByte(21)
      ..write(obj.bookNo)
      ..writeByte(22)
      ..write(obj.isConnected)
      ..writeByte(23)
      ..write(obj.isPayed)
      ..writeByte(24)
      ..write(obj.status)
      ..writeByte(25)
      ..write(obj.seqNo)
      ..writeByte(26)
      ..write(obj.disconnectionTeam)
      ..writeByte(27)
      ..write(obj.proofOfDisconnection)
      ..writeByte(44)
      ..write(obj.jobCode)
      ..writeByte(45)
      ..write(obj.dispatchDateTime)
      ..writeByte(46)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsumerHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
