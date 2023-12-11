import 'dart:async';
import 'dart:convert';

import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

part 'disconnection_provider.g.dart';

@riverpod
class AsyncDisconnection extends _$AsyncDisconnection {
  Future<List<ZoneModel>> _fetchGetDisconnection() async {
    //2020-04-01Z
    List<ZoneModel> zoneList = [];
    String resCode = '';
    try {
      final json = await http
          .get(Uri.https(kHost, '/disconnection'))
          .timeout(const Duration(seconds: 60));
      resCode = json.statusCode.toString();
      if (json.statusCode == 200 || json.statusCode == 201) {
        final todos = List<Map<String, dynamic>>.from(jsonDecode(json.body));
        final consumerList = todos.map(ConsumerModel.fromJson).toList();
        //hunt for same zone and book
        consumerList.forEach((a) {
          var res = zoneList
              .where(
                  (b) => b.bookNumber == a.bookNo && b.zoneNumber == a.zoneNo)
              .toList();
          if (res.isEmpty) {
            var consumerFiltered = consumerList
                .where((c) => c.bookNo == a.bookNo && c.zoneNo == a.zoneNo)
                .toList();
            var zone = ZoneModel(
                barangay: a.address ?? "",
                bookNumber: a.bookNo ?? 0,
                zoneNumber: a.zoneNo ?? 0,
                totalCount: consumerFiltered.length,
                consumerList: consumerFiltered);
            zoneList.add(zone);
          }
        });
        UtilsHandler.zones = zoneList;
      }else{
        throw Exception('Error: ${json.statusCode} \n Failed to load Zones from API');
      }
      return zoneList;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<void> fetchUpdateDisconnection(
      ConsumerModel input, StreamController<bool> events) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final uploadPicture = http.MultipartRequest(
          "POST",
          Uri.https(
              kHost, '/disconnection/${input.disconnectionId}/upload-photo'));
      var singlePhoto = UtilsHandler.mediaFileList![0];
      uploadPicture.files.add(http.MultipartFile.fromBytes(
          'image', await singlePhoto.readAsBytes(),
          contentType: MediaType('image', 'jpg'), filename: singlePhoto.name));
      await uploadPicture.send().then((uploadResponse) async {
        if (uploadResponse.statusCode == 200 ||
            uploadResponse.statusCode == 201) {
          final a = input.toJson();
          print("Uploaded!");
          final response = await http
              .patch(
                  Uri.https(kHost, '/disconnection/${input.disconnectionId}'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(a))
              .timeout(
                const Duration(seconds: 60),
              );
          await Future.delayed(const Duration(seconds: 10));
          if (response.statusCode == 200) {
            events.add(false);
            return _fetchGetDisconnection();
          } else {
            throw Exception('Error: ${uploadResponse.statusCode} /n Failed to update Consumers from API');
          }
        }else{
          throw Exception('Error: ${uploadResponse.statusCode} /n Failed to upload from API');
        }
      });
      UtilsHandler.mediaFileList = [];
      return _fetchGetDisconnection();
    });
  }

  @override
  FutureOr<List<ZoneModel>> build() async {
    return _fetchGetDisconnection();
  }
}
