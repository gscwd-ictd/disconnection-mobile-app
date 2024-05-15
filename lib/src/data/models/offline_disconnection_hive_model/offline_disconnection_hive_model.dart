import 'package:diconnection/src/data/models/consumer_model/consumer_hive_model.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

part 'offline_disconnection_hive_model.g.dart';

@HiveType(typeId: 1)
class OfflineDisconnectionHive {
  @HiveField(4)
  final ConsumerHive consumer;

  @HiveField(5)
  final String photoPath;

  OfflineDisconnectionHive(this.consumer, this.photoPath);
}
