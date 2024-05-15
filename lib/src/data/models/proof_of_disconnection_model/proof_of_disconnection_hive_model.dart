import 'package:hive/hive.dart';

part 'proof_of_disconnection_hive_model.g.dart';

@HiveType(typeId: 5)
class ProofOfDisconnectionHive {
  @HiveField(37)
  final String? id;

  @HiveField(38)
  final String? fileName;

  @HiveField(39)
  final String? timestamptz;

  @HiveField(40)
  final String? disconnectionId;

  @HiveField(41)
  final String? teamId;

  @HiveField(42)
  final String? longitude;

  @HiveField(43)
  final String? latitude;

  ProofOfDisconnectionHive(
      {this.id,
      this.fileName,
      this.timestamptz,
      this.disconnectionId,
      this.teamId,
      this.longitude,
      this.latitude});
}
