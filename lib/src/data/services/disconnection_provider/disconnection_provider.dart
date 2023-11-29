import 'dart:async';
import 'dart:convert';

import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'disconnection_provider.g.dart';

@riverpod
class AsyncDisconnection extends _$AsyncDisconnection {
  Future<List<ZoneModel>> _fetchGetDisconnection() async {
    //2020-04-01Z

    final json = await http.get(Uri.https(kHost,
        '/disconnection')).timeout(const Duration(seconds: 60));
    
    final todos = List<Map<String, dynamic>>.from(jsonDecode(json.body));
    final consumerList = todos.map(ConsumerModel.fromJson).toList();
    List<ZoneModel> zoneList = [];
    //hunt for same zone and book
    consumerList.forEach((a) {
      var res = zoneList.where((b) => b.bookNumber==a.bookNo && b.zoneNumber == a.zoneNo).toList();
      if(res.isEmpty){
        var consumerFiltered = consumerList.where((c) => c.bookNo==a.bookNo && c.zoneNo==a.zoneNo).toList();
        var zone = ZoneModel(
          barangay: a.address ?? "", 
          bookNumber: a.bookNo ?? 0, 
          zoneNumber: a.zoneNo ?? 0, 
          totalCount: consumerFiltered.length, 
          consumerList: consumerFiltered);
        zoneList.add(zone);
      }
     });
    return zoneList;
  }

  Future<void> fetchUpdateDisconnection(ConsumerModel input, StreamController<bool> events) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async{
      final a = input.toJson();
    final response = await http.patch(Uri.https(kHost,
        '/disconnection/${input.disconnectionId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(a)).timeout(const Duration(seconds: 60),
        );
    await Future.delayed(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      events.add(false);
      return _fetchGetDisconnection();
    } else {
      throw Exception('Failed to load Categories from API');
    }
    });
    
  }

  @override
  FutureOr<List<ZoneModel>> build() async {
    return _fetchGetDisconnection();
  }
}