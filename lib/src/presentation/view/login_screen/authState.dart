import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authState.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier{
  @override
  bool build() {
    return false;
  }

  void login(){
    state = true;
  }
  void logout(){
    state = false;
  }
}