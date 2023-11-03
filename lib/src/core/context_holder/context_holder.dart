import 'package:flutter/material.dart';

class ContextKeeper{
  ///This is done to avoid
  static BuildContext buildContext = BuildContext as BuildContext;

  void keepContext(BuildContext context){
    buildContext = context;
  }
}