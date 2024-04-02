import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/core/shared_preferences/get_preferences.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_hive_model.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/data/models/disconnection_handler_model/disconnection_handler_model.dart';
import 'package:diconnection/src/data/models/lib_zones_model/lib_zones_hive_model.dart';
import 'package:diconnection/src/data/models/lib_zones_model/lib_zones_model.dart';
import 'package:diconnection/src/data/models/offline_disconnection_hive_model/offline_disconnection_hive_model.dart';
import 'package:diconnection/src/data/models/proof_of_disconnection_model/proof_of_disconnection_model.dart';
import 'package:diconnection/src/data/models/team_model/team_model.dart';
import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
    var connectivityResult = await (Connectivity().checkConnectivity());
    String token = await GetPreferences().getStoredAccessToken() ?? "";
    kToken = token;
    String hostAPI = UtilsHandler.apiLink == "" ? kHost : UtilsHandler.apiLink;
    //2020-04-01Z
    try {
      List<ConsumerModel> consList = [];
      List<LibZones> libZones = [];
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
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
          consList = consumerList;
          libZones = disc.zoneList!;
          await saveToConsumerBox(consumerList);
          await saveToLibZoneBox(disc.zoneList!);
          // final consumerList = todos.map(DisconnectionHandler.fromJson).toList();
          //hunt for same zone and book
        } else {
          if (json.statusCode == 401) {
            //TODO: Unauthorized
          }
          throw Exception(
              'Error: ${json.statusCode} \n Failed to load Zones from API');
        }
        return convertToZone(consList, libZones);
      } else {
        //Offlinemode Here
        consList = offlineConsumerBox();
        libZones = offLineLibZoneBox();
        return convertToZone(consList, libZones);
      }
    } catch (ex) {
      throw Exception(ex);
    }
  }

  List<ZoneModel> convertToZone(
      List<ConsumerModel> inputs, List<LibZones> libZones) {
    List<ZoneModel> zoneList = [];
    for (var a in inputs) {
      var res = zoneList
          .where((b) => b.bookNumber == a.bookNo && b.zoneNumber == a.zoneNo)
          .toList();
      if (res.isEmpty) {
        var consumerFiltered = inputs
            .where((c) => c.bookNo == a.bookNo && c.zoneNo == a.zoneNo)
            .toList();
        var zoneSel = libZones
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
    }
    //save zoneList
    zoneList.sort((a, b) => a.zoneNumber.compareTo(b.zoneNumber));
    UtilsHandler.zones = zoneList;
    return zoneList;
  }

  List<LibZones> offLineLibZoneBox() {
    final libZonesBox = Hive.box('libZones');
    final libZoneHiveList = libZonesBox.values.toList();
    List<LibZones> libZoneList = [];
    for (var a in libZoneHiveList) {
      var b = a as LibZonesHive;
      final libZone =
          LibZones(zone_code: b.zoneCode, description: b.description);
      libZoneList.add(libZone);
    }
    return libZoneList;
  }

  List<ConsumerModel> offlineConsumerBox() {
    final consumerBox = Hive.box('consumer');
    final consumerHiveList = consumerBox.values.toList();
    List<ConsumerModel> consumerList = [];
    for (var a in consumerHiveList) {
      final b = a as ConsumerHive;
      List<ProofOfDisconnection> proofList = [];
      for (var x in a.proofOfDisconnection!) {
        final proof = ProofOfDisconnection(
            id: x,
            fileName: null,
            timestamptz: null,
            disconnectionId: null,
            teamId: b.disconnectionTeamId,
            longitude: null,
            latitude: null);
        proofList.add(proof);
      }
      final team = Team(
          teamId: b.disconnectionTeamId,
          teamName: null,
          teamLeader: null,
          status: null,
          jobCode: null,
          disconnectionMember: null);

      final consumer = ConsumerModel(
          disconnectionId: a.disconnectionId,
          accountNo: a.accountNo,
          prevAccountNo: a.prevAccountNo,
          consumerName: a.consumerName,
          address: a.address,
          meterNo: a.meterNo,
          billAmount: a.billAmount,
          noOfMonths: a.noOfMonths,
          lastReading: a.lastReading,
          currentReading: a.currentReading,
          remarks: a.remarks,
          disconnectionDate: a.disconnectionDate,
          disconnectedDate: a.disconnectedDate,
          disconnectedTime: a.disconnectedTime,
          zoneNo: a.zoneNo,
          bookNo: a.bookNo,
          isConnected: a.isConnected,
          isPayed: a.isPayed,
          status: a.status,
          seqNo: a.seqNo,
          disconnectionTeam: team,
          proofOfDisconnection: proofList);
      consumerList.add(consumer);
    }
    return consumerList;
  }

  saveToLibZoneBox(List<LibZones> inputs) async {
    final libZonesBox = Hive.box('libZones');
    await libZonesBox.clear();
    List<LibZonesHive> zoneList = [];
    for (var a in inputs) {
      final zone =
          LibZonesHive(zoneCode: a.zone_code, description: a.description);
      zoneList.add(zone);
    }
    await libZonesBox.addAll(zoneList);
  }

  saveToConsumerBox(List<ConsumerModel> inputs) async {
    final consumerBox = Hive.box('consumer');
    await consumerBox.clear();
    List<ConsumerHive> consumerList = [];
    for (var a in inputs) {
      List<String> proofIds = [];
      for (var x in a.proofOfDisconnection!) {
        proofIds.add(x.id!);
      }
      final consumer = ConsumerHive(
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
        disconnectionTeamId: a.disconnectionTeam!.teamId,
        isConnected: a.isConnected,
        isPayed: a.isPayed,
        lastReading: a.lastReading,
        meterNo: a.meterNo,
        noOfMonths: a.noOfMonths,
        prevAccountNo: a.prevAccountNo,
        proofOfDisconnection: proofIds,
        remarks: a.remarks,
        seqNo: a.seqNo,
        status: a.status,
        zoneNo: a.zoneNo,
      );
      consumerList.add(consumer);
    }
    await consumerBox.addAll(consumerList);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _fetchGetDisconnection();
    });
  }

  Future<void> offlineMode(
      ConsumerModel input, StreamController<int> events) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final consumerBox = Hive.box('consumer');
      final consumerList = consumerBox.values.toList();
      final offlineDiscBox = Hive.box('offlineDisconnection');
      final offlineDisc =
          OfflineDisconnectionHive(input, UtilsHandler.mediaFileList![0]);
      offlineDiscBox.add(offlineDisc);
      for (int i = 0; i < consumerList.length; i++) {
        var b = consumerList[i] as ConsumerHive;
        if (b.accountNo!.contains(input.accountNo!)) {
          consumerBox.deleteAt(i);
        }
      }
      events.add(300);
      return _fetchGetDisconnection();
    });
  }

  Future<void> verify(ConsumerModel input, StreamController<int> events) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    String hostAPI = UtilsHandler.apiLink == "" ? kHost : UtilsHandler.apiLink;
    String token = await GetPreferences().getStoredAccessToken() ?? "";
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
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
          if (verify.body == "NotPaid") {
            events.add(200);
          }
          if (verify.body == "Paid") {
            events.add(400);
          }
          if (verify.body == "HasPNOrNotValidBill") {
            events.add(400);
          }
        }
        return _fetchGetDisconnection();
      } else {
        events.add(300);
        return _fetchGetDisconnection();
      }
    });
  }

  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(file.path,
        minWidth: 720, minHeight: 1280, quality: 25, keepExif: true);
    return result!;
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
        var compressFile = await testCompressFile(newFile);
        uploadPicture.files.add(http.MultipartFile.fromBytes(
            'image', compressFile,
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
