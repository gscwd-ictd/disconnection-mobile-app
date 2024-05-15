import 'package:freezed_annotation/freezed_annotation.dart';

part 'remarks_model.freezed.dart';
part 'remarks_model.g.dart';

@freezed
class Remarks with _$Remarks {
  const factory Remarks(
      {required String? id,
      required String? description,
      required bool? isRemarks}) = _Remarks;

  factory Remarks.fromJson(Map<String, dynamic> json) =>
      _$RemarksFromJson(json);
}
