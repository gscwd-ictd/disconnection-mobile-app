import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_model.freezed.dart';
part 'login_model.g.dart';

@freezed
class LoginM with _$LoginM {
  const factory LoginM({required String? username, required String? password}) =
      _LoginM;

  factory LoginM.fromJson(Map<String, dynamic> json) => _$LoginMFromJson(json);
}
