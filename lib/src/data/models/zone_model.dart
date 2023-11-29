import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';

class ZoneModel{
  final String barangay;
  final int bookNumber;
  final int zoneNumber;
  final List<ConsumerModel> consumerList;
  final int totalCount;
  const ZoneModel({required this.barangay,required this.bookNumber,required this.zoneNumber, required this.totalCount, required this.consumerList});
}