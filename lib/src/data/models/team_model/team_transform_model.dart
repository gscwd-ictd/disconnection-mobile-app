import 'package:diconnection/src/data/models/member_model/member_hive_model.dart';
import 'package:diconnection/src/data/models/member_model/member_model.dart';
import 'package:diconnection/src/data/models/member_model/member_transform_model.dart';
import 'package:diconnection/src/data/models/team_model/team_hive_model.dart';
import 'package:diconnection/src/data/models/team_model/team_model.dart';

class TeamTransFormModel {
  Team hiveToModel(TeamHive input) {
    List<Member> memberList = [];
    if (input.disconnectionMember != null) {
      for (MemberHive a in input.disconnectionMember!) {
        final member = MemberTransform().hiveToModel(a);
        memberList.add(member);
      }
    }
    final team = Team(
        teamId: input.teamId,
        teamName: input.teamName,
        teamLeader: input.teamLeader,
        status: input.status,
        jobCode: input.jobCode,
        disconnectionMember: memberList);
    return team;
  }

  TeamHive modeltoHive(Team input) {
    List<MemberHive> memberList = [];
    if (input.disconnectionMember != null) {
      for (Member a in input.disconnectionMember!) {
        final member = MemberTransform().modeltoHive(a);
        memberList.add(member);
      }
    }
    final team = TeamHive(
        disconnectionMember: memberList,
        jobCode: input.jobCode,
        status: input.status,
        teamId: input.teamId,
        teamLeader: input.teamLeader,
        teamName: input.teamName);
    return team;
  }
}
