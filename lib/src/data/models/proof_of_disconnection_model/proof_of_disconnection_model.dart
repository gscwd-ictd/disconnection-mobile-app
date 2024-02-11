import 'package:freezed_annotation/freezed_annotation.dart';

part 'proof_of_disconnection_model.freezed.dart';
part 'proof_of_disconnection_model.g.dart';

@freezed
class ProofOfDisconnection with _$ProofOfDisconnection {
  const factory ProofOfDisconnection(
      {required String? id,
      required String? fileName,
      required String? timestamptz,
      required String? disconnectionId,
      required String? teamId,
      required String? longitude,
      required String? latitude}) = _ProofOfDisconnection;

  factory ProofOfDisconnection.fromJson(Map<String, dynamic> json) =>
      _$ProofOfDisconnectionFromJson(json);
}
