import 'package:diconnection/src/data/models/member_model/member_hive_model.dart';
import 'package:diconnection/src/data/models/member_model/member_model.dart';

class MemberTransform {
  Member hiveToModel(MemberHive input) {
    final member = Member(
        memberId: input.memberId,
        companyId: input.companyId,
        memberName: input.memberName,
        disconnectorCode: input.disconnectorCode);
    return member;
  }

  MemberHive modeltoHive(Member input) {
    final member = MemberHive(
        companyId: input.companyId,
        disconnectorCode: input.disconnectorCode,
        memberId: input.memberId,
        memberName: input.memberName);
    return member;
  }
}
