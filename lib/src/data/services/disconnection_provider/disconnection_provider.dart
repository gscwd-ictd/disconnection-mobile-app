import 'dart:async';
import 'dart:convert';

import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

part 'disconnection_provider.g.dart';

@riverpod
class AsyncDisconnection extends _$AsyncDisconnection {
  Future<List<ZoneModel>> _fetchGetDisconnection() async {
    String hostAPI = UtilsHandler.apiLink == "" ? kHost : UtilsHandler.apiLink;
    //2020-04-01Z
    List<ZoneModel> zoneList = [];
    try {
      final json = await http
          .get(Uri.https(hostAPI, '/disconnection'))
          .timeout(const Duration(seconds: 60));
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
        //save zoneList
        UtilsHandler.zones = zoneList;
      } else {
        throw Exception(
            'Error: ${json.statusCode} \n Failed to load Zones from API');
      }
      return zoneList;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<void> fetchUpdateDisconnection(
      ConsumerModel input, StreamController<int> events) async {
    String hostAPI = UtilsHandler.apiLink == "" ? kHost : UtilsHandler.apiLink;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      Position currentPosition;
      double lat = 0, long = 0;
      try {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high)
            .then((Position position) {
          currentPosition = position;
          lat = position.latitude;
          long = position.longitude;
          // _getAddressFromLatLng(_currentPosition!);
        }).catchError((e) {
          // debugPrint(e);
        });
        final verify = await http
            .get(Uri.https(hostAPI, '/disconnection/getVerify', {
              "accountNo": input.accountNo,
              "disconnectionDate": input.disconnectionDate.toString()
            }))
            .timeout(const Duration(seconds: 60));
        if (verify.statusCode == 200 || verify.statusCode == 201) {
          events.add(1);
          if (verify.body == "NotPayed") {
            var inputs = '${input.disconnectionId}/$lat/$long';
            final uploadPicture = http.MultipartRequest("POST",
                Uri.https(hostAPI, '/disconnection/$inputs/upload-photo'));
            var singlePhoto = UtilsHandler.mediaFileList![0];
            uploadPicture.files.add(http.MultipartFile.fromBytes(
                'image', await singlePhoto.readAsBytes(),
                contentType: MediaType('image', 'jpg'),
                filename: singlePhoto.name));
            await uploadPicture.send().then((uploadResponse) async {
              if (uploadResponse.statusCode == 200 ||
                  uploadResponse.statusCode == 201) {
                events.add(2);
                final a = input.toJson();
                print("Uploaded!");
                final response = await http
                    .patch(
                        Uri.https(
                            kHost, '/disconnection/${input.disconnectionId}'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(a))
                    .timeout(
                      const Duration(seconds: 60),
                    );
                await Future.delayed(const Duration(seconds: 10));
                if (response.statusCode == 200) {
                  UtilsHandler.mediaFileList = [];
                  events.add(3);
                  return _fetchGetDisconnection();
                } else {
                  events.add(502);
                }
              } else {
                events.add(501);
              }
            });
            return _fetchGetDisconnection();
          } else {
            if (verify.body == "NotPayed") {
              events.add(400);
            } else {
              events.add(500);
            }
          }
        } else {
          events.add(500);
        }
        return _fetchGetDisconnection();
      } catch (ex) {
        print(ex);
        events.add(800);
        throw Exception(ex);
      }
    });
  }

  @override
  FutureOr<List<ZoneModel>> build() async {
    return _fetchGetDisconnection();
  }
}
