// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeamHiveAdapter extends TypeAdapter<TeamHive> {
  @override
  final int typeId = 6;

  @override
  TeamHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeamHive(
      teamId: fields[28] as String?,
      teamName: fields[29] as String?,
      teamLeader: fields[30] as String?,
      status: fields[31] as bool?,
      jobCode: fields[32] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TeamHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(28)
      ..write(obj.teamId)
      ..writeByte(29)
      ..write(obj.teamName)
      ..writeByte(30)
      ..write(obj.teamLeader)
      ..writeByte(31)
      ..write(obj.status)
      ..writeByte(32)
      ..write(obj.jobCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
