import 'dart:convert';
import 'package:diconnection/src/data/models/viewLedger_model/viewLedger_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
part 'disconnect_service.g.dart';

@riverpod
Stream<List<dynamic>> chat(ChatRef ref) async* {
  var logger = Logger();
  final dio = Dio();
  try {
    final response = await dio.get('http://localhost:3000/view-ledger');
    var list = (json.decode(response.data))
          .map((data) => ViewLedger.fromJson(data))
          .toList();
    logger.i(list);
      yield* list;
    } catch (e) {
      logger.t(e);
      throw Exception(e);
    }
}