// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proof_of_disconnection_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProofOfDisconnectionHiveAdapter
    extends TypeAdapter<ProofOfDisconnectionHive> {
  @override
  final int typeId = 5;

  @override
  ProofOfDisconnectionHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProofOfDisconnectionHive(
      id: fields[37] as String?,
      fileName: fields[38] as String?,
      timestamptz: fields[39] as String?,
      disconnectionId: fields[40] as String?,
      teamId: fields[41] as String?,
      longitude: fields[42] as String?,
      latitude: fields[43] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProofOfDisconnectionHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(37)
      ..write(obj.id)
      ..writeByte(38)
      ..write(obj.fileName)
      ..writeByte(39)
      ..write(obj.timestamptz)
      ..writeByte(40)
      ..write(obj.disconnectionId)
      ..writeByte(41)
      ..write(obj.teamId)
      ..writeByte(42)
      ..write(obj.longitude)
      ..writeByte(43)
      ..write(obj.latitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProofOfDisconnectionHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
