import 'package:hive/hive.dart';

part 'lib_zones_hive_model.g.dart';

@HiveType(typeId: 3)
class LibZonesHive {
  @HiveField(26)
  final String? zoneCode;

  @HiveField(27)
  final String? description;

  LibZonesHive({this.zoneCode, this.description});
}
