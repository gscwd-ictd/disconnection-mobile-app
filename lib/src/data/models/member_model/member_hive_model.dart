import 'package:hive/hive.dart';

part 'member_hive_model.g.dart';

@HiveType(typeId: 4)
class MemberHive {
  @HiveField(33)
  final String? memberId;

  @HiveField(34)
  final String? companyId;

  @HiveField(35)
  final String? memberName;

  @HiveField(36)
  final int? disconnectorCode;

  MemberHive(
      {this.memberId, this.companyId, this.memberName, this.disconnectorCode});
}
