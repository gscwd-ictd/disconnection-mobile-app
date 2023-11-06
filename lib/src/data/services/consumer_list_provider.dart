
import 'dart:convert';
import 'package:diconnection/src/data/models/player_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final apiServiceProvider = Provider<ConsumerListApiService>((ref) => ConsumerListApiService());

class ConsumerListApiService {
  var logger = Logger();
  Future<List<dynamic>> getUser() async {
    try {
      final response =
          await http.get(Uri.parse("https://www.balldontlie.io/api/v1/players"));
    var list = (json.decode(response.body)['data'])
          .map((data) => PlayerModel.fromJson(data))
          .toList();
    logger.i(list);
      return list;
    } catch (e) {
      logger.t(e);
      throw Exception(e);
    }
  }
}