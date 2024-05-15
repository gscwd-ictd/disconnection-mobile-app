import 'package:freezed_annotation/freezed_annotation.dart';

part 'lib_zones_model.freezed.dart';
part 'lib_zones_model.g.dart';

@freezed
class LibZones with _$LibZones {
  const factory LibZones(
      {required String? zone_code, required String? description}) = _LibZones;

  factory LibZones.fromJson(Map<String, dynamic> json) =>
      _$LibZonesFromJson(json);
}
