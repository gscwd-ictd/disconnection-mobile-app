import 'dart:convert';

import 'package:diconnection/src/data/models/viewLedger_model/viewLedger_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'view_ledger_provider.g.dart';

@riverpod
class AsyncViewLedger extends _$AsyncViewLedger {
  Future<List<ViewLedger>> _fetchViewLedger() async {
    //2020-04-01Z

    final json = await http.get(Uri.https('f9b5-122-3-104-117.ngrok.io',
        '/view-ledger/2020-04-01Z')).timeout(const Duration(seconds: 60));
    
    final todos = List<Map<String, dynamic>>.from(jsonDecode(json.body));
    final viewLedgerList = todos.map(ViewLedger.fromJson).toList();
    return viewLedgerList;
  }

  @override
  FutureOr<List<ViewLedger>> build() async {
    return _fetchViewLedger();
  }
}