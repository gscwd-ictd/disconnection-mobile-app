import 'package:diconnection/src/data/models/member_model/member_hive_model.dart';
import 'package:hive/hive.dart';

part 'team_hive_model.g.dart';

@HiveType(typeId: 6)
class TeamHive {
  @HiveField(28)
  final String? teamId;

  @HiveField(29)
  final String? teamName;

  @HiveField(30)
  final String? teamLeader;

  @HiveField(31)
  final bool? status;

  @HiveField(32)
  final int? jobCode;

  List<MemberHive>? disconnectionMember;

  TeamHive(
      {this.teamId,
      this.teamName,
      this.teamLeader,
      this.status,
      this.jobCode,
      this.disconnectionMember});
}
