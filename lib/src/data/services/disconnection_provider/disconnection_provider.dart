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
import 'package:diconnection/src/data/models/proof_of_disconnection_model/proof_of_disconnection_transform.dart';
import 'package:diconnection/src/data/models/team_model/team_transform_model.dart';
import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:native_exif/native_exif.dart';
import 'package:path_provider/path_provider.dart';
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
          disconnectionTeam:
              TeamTransFormModel().hiveToModel(a.disconnectionTeam!),
          proofOfDisconnection: ProofOfDisconnectionTransform()
              .listHiveToListModel(a.proofOfDisconnection!));
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
    for (var a in inputs) {
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
        disconnectionTeam:
            TeamTransFormModel().modeltoHive(a.disconnectionTeam!),
        isConnected: a.isConnected,
        isPayed: a.isPayed,
        lastReading: a.lastReading,
        meterNo: a.meterNo,
        noOfMonths: a.noOfMonths,
        prevAccountNo: a.prevAccountNo,
        proofOfDisconnection: ProofOfDisconnectionTransform()
            .listModelToListHive(a.proofOfDisconnection!),
        remarks: a.remarks,
        seqNo: a.seqNo,
        status: a.status,
        zoneNo: a.zoneNo,
      );
      await consumerBox.put(a.disconnectionId, consumer);
    }
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
      List<String> proofs = [];
      if (input.proofOfDisconnection != null) {
        for (var a in input.proofOfDisconnection!) {
          proofs.add(a.id!);
        }
      }
      final consumerHive = ConsumerHive(
          accountNo: input.accountNo,
          address: input.address,
          billAmount: input.billAmount,
          bookNo: input.bookNo,
          consumerName: input.consumerName,
          currentReading: input.currentReading,
          disconnectedDate: input.disconnectedDate,
          disconnectedTime: input.disconnectedTime,
          disconnectionDate: input.disconnectionDate,
          disconnectionId: input.disconnectionId,
          disconnectionTeam:
              TeamTransFormModel().modeltoHive(input.disconnectionTeam!),
          isConnected: input.isConnected,
          isPayed: input.isPayed,
          lastReading: input.lastReading,
          meterNo: input.meterNo,
          noOfMonths: input.noOfMonths,
          prevAccountNo: input.prevAccountNo,
          proofOfDisconnection: ProofOfDisconnectionTransform()
              .listModelToListHive(input.proofOfDisconnection!),
          remarks: input.remarks,
          seqNo: input.seqNo,
          status: input.status,
          zoneNo: input.zoneNo);
      final singlePhoto = await compressAndGet(UtilsHandler.mediaFileList![0]);
      var base64Image = base64.encode(singlePhoto);
      final offlineDisc = OfflineDisconnectionHive(consumerHive, base64Image);
      offlineDiscBox.put(consumerHive.disconnectionId, offlineDisc);
      for (int i = 0; i < consumerList.length; i++) {
        var b = consumerList[i] as ConsumerHive;
        if (b.accountNo!.contains(input.accountNo!)) {
          await consumerBox.deleteAt(i);
        }
      }
      final disconnectionList = offlineDiscBox.values.toList();
      int length = disconnectionList.length;
      UtilsHandler.loadingPanel = "Synching Available: $length disconnection";
      UtilsHandler.isAvailableToSync = true;
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
            events.add(410);
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

  Future<Uint8List> compressAndGet(XFile file) async {
    // var name = file.name;
    // Directory tempDir = await getTemporaryDirectory();
    // String tempPath = '${tempDir.path}/${name}1';
    var result = await FlutterImageCompress.compressWithFile(file.path,
        minWidth: 720, minHeight: 1280, quality: 25, keepExif: true);
    return result!;
  }

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
        zoneNo: a.zoneNo);
    return consumerModel;
  }

  Future<void> syncAll() async {
    String hostAPI = UtilsHandler.apiLink == "" ? kHost : UtilsHandler.apiLink;
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
          print('${count + 1}/${disconnectionList.length}');
          Map<String, String> headers = {"Authorization": "Bearer $token"};
          var inputs = '${a.consumer.disconnectionId}/$lat/$long';
          final uploadPicture = http.MultipartRequest(
              "POST",
              isHttp
                  ? Uri.http(hostAPI, '/disconnection/$inputs/upload-photo')
                  : Uri.https(hostAPI, '/disconnection/$inputs/upload-photo'));
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
          await exif.writeAttributes(
              {"GPSLatitude": lat.toString(), "GPSLongitude": long.toString()});
          uploadPicture.files.add(http.MultipartFile.fromBytes(
              'image', decodedimgfile.readAsBytesSync(),
              contentType: MediaType('image', 'jpg'),
              filename: '$fileName.jpg'));
          await uploadPicture.send().then((uploadResponse) async {
            if (uploadResponse.statusCode == 200 ||
                uploadResponse.statusCode == 201) {
              final b = consumerHiveToModel(a.consumer).toJson();
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
                return _fetchGetDisconnection();
              } else {
                if (response.statusCode == 401) {
                  //TODO: Unauthorized
                } else {}
              }
            }
          });
          offlineDiscBox.deleteAt(count);
          count++;
        }
      } catch (ex) {}
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
                events.add(401);
              } else {
                events.add(502);
              }
            }
          } else {
            if (uploadResponse.statusCode == 401) {
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
