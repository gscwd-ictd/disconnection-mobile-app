import 'package:diconnection/src/data/models/consumer_model/consumer_hive_model.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/data/models/proof_of_disconnection_model/proof_of_disconnection_transform.dart';
import 'package:diconnection/src/data/models/team_model/team_transform_model.dart';

class ConsumerTransform {
  ConsumerModel consumerHiveToModel(ConsumerHive a) {
    final consumerModel = ConsumerModel(
        accountNo: a.accountNo,
        address: a.address,
        billAmount: a.billAmount,
        bookNo: a.bookNo,
        consumerName: a.consumerName,
        currentReading: a.currentReading,
        disconnectedDate: a.disconnectedDate,
        disconnectedTime: a.disconnectedTime,
        disconnectionDate: a.disconnectionDate,
        disconnectionId: a.disconnectionId,
        disconnectionTeam:
            TeamTransFormModel().hiveToModel(a.disconnectionTeam!),
        isConnected: a.isConnected,
        isPayed: a.isPayed,
        lastReading: a.lastReading,
        meterNo: a.meterNo,
        noOfMonths: a.noOfMonths,
        prevAccountNo: a.prevAccountNo,
        proofOfDisconnection: ProofOfDisconnectionTransform()
            .listHiveToListModel(a.proofOfDisconnection!),
        remarks: a.remarks,
        seqNo: a.seqNo,
        status: a.status,
        zoneNo: a.zoneNo,
        jobCode: a.jobCode);
    return consumerModel;
  }
}
