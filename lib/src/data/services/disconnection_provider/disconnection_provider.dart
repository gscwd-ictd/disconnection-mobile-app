import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/core/shared_preferences/get_preferences.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/data/models/disconnection_handler_model/disconnection_handler_model.dart';
import 'package:diconnection/src/data/models/offline_disconnection_hive_model/offline_disconnection_hive_model.dart';
import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:native_exif/native_exif.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

part 'disconnection_provider.g.dart';

@riverpod
class AsyncDisconnection extends _$AsyncDisconnection {
  Future<List<ZoneModel>> _fetchGetDisconnection() async {
    final consumerBox = Hive.box('consumer');
    String token = await GetPreferences().getStoredAccessToken() ?? "";
    kToken = token;
    String hostAPI = UtilsHandler.apiLink == "" ? kHost : UtilsHandler.apiLink;
    //2020-04-01Z
    List<ZoneModel> zoneList = [];
    try {
      final json = await http.get(
          isHttp
              ? Uri.http(hostAPI, '/disconnection')
              : Uri.https(hostAPI, '/disconnection'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }).timeout(const Duration(seconds: 60));
      if (json.statusCode == 200 || json.statusCode == 201) {
        // final todos = Map<String, dynamic>.from(jsonDecode(json.body));
        final disc = DisconnectionHandler.fromJson(jsonDecode(json.body));
        final consumerList = disc.items!.toList();
        // final consumerList = todos.map(DisconnectionHandler.fromJson).toList();
        //hunt for same zone and book
        consumerList!.forEach((a) {
          var res = zoneList
              .where(
                  (b) => b.bookNumber == a.bookNo && b.zoneNumber == a.zoneNo)
              .toList();
          if (res.isEmpty) {
            var consumerFiltered = consumerList
                .where((c) => c.bookNo == a.bookNo && c.zoneNo == a.zoneNo)
                .toList();
            var zoneSel = disc.zoneList!
                .toList()
                .firstWhere((e) => e.zone_code!.contains(a.zoneNo.toString()));
            var zone = ZoneModel(
                barangay: "${zoneSel.description ?? ""} ,Book ${a.bookNo}",
                bookNumber: a.bookNo ?? 0,
                zoneNumber: a.zoneNo ?? 0,
                totalCount: consumerFiltered.length,
                consumerList: consumerFiltered);
            zoneList.add(zone);
          }
        });
        //save zoneList
        zoneList.sort((a, b) => a.zoneNumber.compareTo(b.zoneNumber));
        UtilsHandler.zones = zoneList;
      } else {
        if (json.statusCode == 401) {
          //TODO: Unauthorized
        }
        throw Exception(
            'Error: ${json.statusCode} \n Failed to load Zones from API');
      }
      return zoneList;
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _fetchGetDisconnection();
    });
  }

  Future<void> offlineMode(ConsumerModel input) async {
    final offlineDiscBox = Hive.box('offlineDisconnection');
    final offlineDisc =
        OfflineDisconnectionHive(input, UtilsHandler.mediaFileList![0]);
    offlineDiscBox.add(offlineDisc);
  }

  Future<void> verify(ConsumerModel input, StreamController<int> events) async {
    String hostAPI = UtilsHandler.apiLink == "" ? kHost : UtilsHandler.apiLink;
    String token = await GetPreferences().getStoredAccessToken() ?? "";
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final verify = await http.get(
          isHttp
              ? Uri.http(hostAPI, '/disconnection/getVerify', {
                  "accountNo": input.accountNo,
                  "disconnectionDate":
                      input.disconnectionDate!.toLocal().toIso8601String()
                })
              : Uri.https(hostAPI, '/disconnection/getVerify', {
                  "accountNo": input.accountNo,
                  "disconnectionDate":
                      input.disconnectionDate!.toLocal().toIso8601String()
                }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }).timeout(const Duration(seconds: 60));
      if (verify.statusCode == 200 || verify.statusCode == 201) {
        if (verify.body == "NotPayed") {
          events.add(200);
        }
        if (verify.body == "Payed") {
          events.add(400);
        }
        if (verify.body == "HasPNOrNotValidBill") {
          events.add(400);
        }
      }
      return _fetchGetDisconnection();
    });
  }

  Future<void> fetchUpdateDisconnection(
      ConsumerModel input, StreamController<int> events) async {
    String hostAPI = UtilsHandler.apiLink == "" ? kHost : UtilsHandler.apiLink;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      String token = await GetPreferences().getStoredAccessToken() ?? "";
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
        Map<String, String> headers = {"Authorization": "Bearer $token"};
        var inputs = '${input.disconnectionId}/$lat/$long';
        final uploadPicture = http.MultipartRequest(
            "POST",
            isHttp
                ? Uri.http(hostAPI, '/disconnection/$inputs/upload-photo')
                : Uri.https(hostAPI, '/disconnection/$inputs/upload-photo'));
        uploadPicture.headers.addAll(headers);
        var singlePhoto = UtilsHandler.mediaFileList![0];
        var exif = await Exif.fromPath(singlePhoto.path);
        await exif.writeAttributes(
            {"GPSLatitude": lat.toString(), "GPSLongitude": long.toString()});
        final newFile = File(singlePhoto.path);
        await newFile.writeAsBytes(await singlePhoto.readAsBytes());
        await exif.close();
        uploadPicture.files.add(http.MultipartFile.fromBytes(
            'image', await newFile.readAsBytes(),
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
                  isHttp
                      ? Uri.http(
                          hostAPI, '/disconnection/${input.disconnectionId}')
                      : Uri.https(
                          kHost, '/disconnection/${input.disconnectionId}'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Accept': 'application/json',
                    'Authorization': 'Bearer $token',
                  },
                  body: jsonEncode(a),
                )
                .timeout(
                  const Duration(seconds: 60),
                );
            await Future.delayed(const Duration(seconds: 10));
            if (response.statusCode == 200) {
              UtilsHandler.mediaFileList = [];
              events.add(3);
              return _fetchGetDisconnection();
            } else {
              if (response.statusCode == 401) {
                //TODO: Unauthorized
                events.add(401);
              } else {
                events.add(502);
              }
            }
          } else {
            if (uploadResponse.statusCode == 401) {
              //TODO: Unauthorized
              events.add(401);
            } else {
              events.add(501);
            }
          }
        });
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
