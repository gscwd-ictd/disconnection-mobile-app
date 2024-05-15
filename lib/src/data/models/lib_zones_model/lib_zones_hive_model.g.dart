// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lib_zones_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibZonesHiveAdapter extends TypeAdapter<LibZonesHive> {
  @override
  final int typeId = 3;

  @override
  LibZonesHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LibZonesHive(
      zoneCode: fields[26] as String?,
      description: fields[27] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LibZonesHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(26)
      ..write(obj.zoneCode)
      ..writeByte(27)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibZonesHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
