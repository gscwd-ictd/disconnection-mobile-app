// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_user_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SuperUserHiveAdapter extends TypeAdapter<SuperUserHive> {
  @override
  final int typeId = 0;

  @override
  SuperUserHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SuperUserHive(
      fields[0] as String,
      fields[1] as String,
      fields[3] as String,
      fields[2] as Team,
    );
  }

  @override
  void write(BinaryWriter writer, SuperUserHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.team)
      ..writeByte(3)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuperUserHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
