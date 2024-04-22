import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/core/shared_preferences/get_preferences.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_trasform.dart';
import 'package:diconnection/src/data/models/offline_disconnection_hive_model/offline_disconnection_hive_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:native_exif/native_exif.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'sync_provider.g.dart';

@riverpod
class AsyncSync extends _$AsyncSync {
  Future<int> _fetchSyncData() async {
    int length = 0;
    //2020-04-01Z
    try {
      final offlineDiscBox = Hive.box('offlineDisconnection');
      final disconnectionList = offlineDiscBox.values.toList();
      length = disconnectionList.length;
      if (length > 0) {
        UtilsHandler.loadingPanel = "Synching Available: $length disconnection";
        UtilsHandler.isAvailableToSync = true;
        UtilsHandler.doneSync = true;
      } else {
        UtilsHandler.doneSync = true;
        UtilsHandler.isAvailableToSync = false;
      }
    } catch (ex) {
      print(ex);
    }
    UtilsHandler.executed = false;
    return length;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return _fetchSyncData();
    });
  }

  Future<void> syncAll() async {
    if (!UtilsHandler.executed) {
      UtilsHandler.executed = true;
      UtilsHandler.loadingPanel = "Synching Start ";
      print("Synching Start ");
      UtilsHandler.doneSync = false;
      String hostAPI =
          UtilsHandler.apiLink == "" ? kHost : UtilsHandler.apiLink;
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        String token = await GetPreferences().getStoredAccessToken() ?? "";
        Position currentPosition;
        double lat = 0, long = 0;
        final offlineDiscBox = Hive.box('offlineDisconnection');
        final disconnectionList = offlineDiscBox.values.toList();
        Logger logger = Logger();
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
          int count = 0;
          for (OfflineDisconnectionHive a in disconnectionList) {
            print('Synching: ${count + 1}/${disconnectionList.length} ');
            UtilsHandler.loadingPanel =
                'Synching: ${count + 1}/${disconnectionList.length} ';
            Map<String, String> headers = {"Authorization": "Bearer $token"};
            var inputs = '${a.consumer.disconnectionId}/$lat/$long';
            final uploadPicture = http.MultipartRequest(
                "POST",
                isHttp
                    ? Uri.http(hostAPI, '/disconnection/$inputs/upload-photo')
                    : Uri.https(
                        hostAPI, '/disconnection/$inputs/upload-photo'));
            uploadPicture.headers.addAll(headers);
            // Get temporary directory
            final dir = await getTemporaryDirectory();
            var fileName = DateTime.now().millisecondsSinceEpoch.toString();
            var pathAndName = '${dir.path}/$fileName.jpg';
            Uint8List decodedbytes = base64.decode(a.photoPath);
            File decodedimgfile =
                await File(pathAndName).writeAsBytes(decodedbytes);
            String decodedpath = decodedimgfile.path;
            var exif = await Exif.fromPath(decodedpath);
            await exif.writeAttributes({
              "GPSLatitude": lat.toString(),
              "GPSLongitude": long.toString()
            });
            uploadPicture.files.add(http.MultipartFile.fromBytes(
                'image', decodedimgfile.readAsBytesSync(),
                contentType: MediaType('image', 'jpg'),
                filename: '$fileName.jpg'));
            await uploadPicture.send().then((uploadResponse) async {
              if (uploadResponse.statusCode == 200 ||
                  uploadResponse.statusCode == 201) {
                final b = ConsumerTransform()
                    .consumerHiveToModel(a.consumer)
                    .toJson();
                print("Uploaded!");
                final response = await http
                    .patch(
                      isHttp
                          ? Uri.http(hostAPI,
                              '/disconnection/${a.consumer.disconnectionId}')
                          : Uri.https(kHost,
                              '/disconnection/${a.consumer.disconnectionId}'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Accept': 'application/json',
                        'Authorization': 'Bearer $token',
                      },
                      body: jsonEncode(b),
                    )
                    .timeout(
                      const Duration(seconds: 60),
                    );
                await Future.delayed(const Duration(seconds: 10));
                if (response.statusCode == 200) {
                  UtilsHandler.mediaFileList = [];
                  // return _fetchSyncData();
                } else {
                  if (response.statusCode == 401) {
                    //TODO: Unauthorized
                  } else {}
                }
              }
            });
            await offlineDiscBox.delete(a.consumer.disconnectionId);
            count++;
          }
          UtilsHandler.loadingPanel = "Synching Done";
          print('Synching Done');
          UtilsHandler.doneSync = true;
          await Future.delayed(const Duration(seconds: 4));
          UtilsHandler.isAvailableToSync = false;
        } catch (ex) {}
        return _fetchSyncData();
      });
    }
  }

  @override
  FutureOr<int> build() async {
    return _fetchSyncData();
  }
}
