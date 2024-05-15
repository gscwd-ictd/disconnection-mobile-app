import 'package:diconnection/src/data/models/proof_of_disconnection_model/proof_of_disconnection_hive_model.dart';
import 'package:diconnection/src/data/models/proof_of_disconnection_model/proof_of_disconnection_model.dart';

class ProofOfDisconnectionTransform {
  ProofOfDisconnection hiveToModel(ProofOfDisconnectionHive input) {
    final proof = ProofOfDisconnection(
        id: input.id,
        fileName: input.fileName,
        timestamptz: input.timestamptz,
        disconnectionId: input.disconnectionId,
        teamId: input.teamId,
        longitude: input.longitude,
        latitude: input.latitude);
    return proof;
  }

  ProofOfDisconnectionHive modelToHive(ProofOfDisconnection input) {
    final proof = ProofOfDisconnectionHive(
        disconnectionId: input.disconnectionId,
        fileName: input.fileName,
        id: input.id,
        latitude: input.latitude,
        longitude: input.longitude,
        teamId: input.teamId,
        timestamptz: input.timestamptz);

    return proof;
  }

  List<ProofOfDisconnection> listHiveToListModel(
      List<ProofOfDisconnectionHive> input) {
    List<ProofOfDisconnection> proofList = [];
    for (var a in input) {
      final proof = hiveToModel(a);
      proofList.add(proof);
    }
    return proofList;
  }

  List<ProofOfDisconnectionHive> listModelToListHive(
      List<ProofOfDisconnection> input) {
    List<ProofOfDisconnectionHive> proofList = [];
    for (var a in input) {
      final proof = modelToHive(a);
      proofList.add(proof);
    }
    return proofList;
  }
}
