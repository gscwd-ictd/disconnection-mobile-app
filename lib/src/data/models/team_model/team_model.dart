import 'package:diconnection/src/data/models/member_model/member_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_model.freezed.dart';
part 'team_model.g.dart';

@freezed
class Team with _$Team {
  const factory Team(
      {required String? teamId,
      required String? teamName,
      required String? teamLeader,
      required bool? status,
      required int? jobCode,
      required List<Member>? disconnectionMember}) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}
