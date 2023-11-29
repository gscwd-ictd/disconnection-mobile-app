import 'dart:convert';

import 'package:diconnection/src/data/models/user_model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'auth_provider.g.dart';

@riverpod
class AsyncAuth extends _$AsyncAuth {
  Future<List<User>> _fetchUser() async {
    //2020-04-01Z

    final json = await http.get(Uri.https('f9b5-122-3-104-117.ngrok.io',
        '/view-ledger/2020-04-01Z')).timeout(const Duration(seconds: 60));
    
    final todos = List<Map<String, dynamic>>.from(jsonDecode(json.body));
    final UserList = todos.map(User.fromJson).toList();
    return UserList;
  }

  @override
  FutureOr<List<User>> build() async {
    return _fetchUser();
  }
}