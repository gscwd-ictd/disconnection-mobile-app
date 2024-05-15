// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemberHiveAdapter extends TypeAdapter<MemberHive> {
  @override
  final int typeId = 4;

  @override
  MemberHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemberHive(
      memberId: fields[33] as String?,
      companyId: fields[34] as String?,
      memberName: fields[35] as String?,
      disconnectorCode: fields[36] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MemberHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(33)
      ..write(obj.memberId)
      ..writeByte(34)
      ..write(obj.companyId)
      ..writeByte(35)
      ..write(obj.memberName)
      ..writeByte(36)
      ..write(obj.disconnectorCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
