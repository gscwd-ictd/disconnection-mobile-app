// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_disconnection_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineDisconnectionHiveAdapter
    extends TypeAdapter<OfflineDisconnectionHive> {
  @override
  final int typeId = 1;

  @override
  OfflineDisconnectionHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineDisconnectionHive(
      fields[4] as ConsumerModel,
      fields[5] as XFile,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineDisconnectionHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(4)
      ..write(obj.consumer)
      ..writeByte(5)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineDisconnectionHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
