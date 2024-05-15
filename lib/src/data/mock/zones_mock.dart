import 'package:diconnection/src/data/mock/consumer_mock.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/data/models/zone_model.dart';

List<ConsumerModel> a = ConsumerMockData.consumerListA;
List<ConsumerModel> b = ConsumerMockData.consumerListB;
class ZonesMock{
  static List<ZoneModel> zoneList = [
    ZoneModel(
      barangay: "San Isidro", 
      bookNumber: 1, zoneNumber: 1, 
      totalCount: a.length, 
      consumerList: a ),
      ZoneModel(
      barangay: "San Isidro", 
      bookNumber: 13, zoneNumber: 2, 
      totalCount: b.length, 
      consumerList: b )
    ];
}