import 'package:diconnection/src/data/models/team_model/team_model.dart';
import 'package:hive/hive.dart';

part 'super_user_hive_model.g.dart';

@HiveType(typeId: 0)
class SuperUserHive {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final Team team;

  @HiveField(3)
  final String token;

  SuperUserHive(this.userId, this.username, this.token, this.team);
}
