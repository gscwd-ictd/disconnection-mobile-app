import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

part 'offline_disconnection_hive_model.g.dart';

@HiveType(typeId: 1)
class OfflineDisconnectionHive {
  @HiveField(4)
  final ConsumerModel consumer;

  @HiveField(5)
  final XFile photo;

  OfflineDisconnectionHive(this.consumer, this.photo);
}
