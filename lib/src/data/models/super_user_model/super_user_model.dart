import 'package:diconnection/src/data/models/member_model/member_model.dart';
import 'package:diconnection/src/data/models/team_model/team_model.dart';
import 'package:diconnection/src/data/models/user_model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'super_user_model.freezed.dart';
part 'super_user_model.g.dart';

@freezed
class SuperUser with _$SuperUser {
  const factory SuperUser(
      {required String? userId,
      required String? username,
      required Team? team,
      required String? accessToken}) = _SuperUser;

  factory SuperUser.fromJson(Map<String, dynamic> json) =>
      _$SuperUserFromJson(json);
}
