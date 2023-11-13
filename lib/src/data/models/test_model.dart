import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'test_model.g.dart';

@riverpod
Future<String> boredSuggestion(BoredSuggestionRef ref) async {
  final response = await http.get(
    Uri.https('https://boredapi.com/api/activity'),
  );
  final json = jsonDecode(response.body) as Map;
  return json['activity']! as String;
}