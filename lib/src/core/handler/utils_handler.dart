import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/models/value_item.dart';

class UtilsHandler {
  static bool hasConnection = true;
  static List<ZoneModel> zones = [];
  static List<XFile>? mediaFileList = [];
  static String apiLink = "";
  final TextEditingController userText = TextEditingController();
  final TextEditingController passText = TextEditingController();
  static bool doneSync = false;
  static bool isAvailableToSync = false;
  static bool executed = false;
  static bool isInitialized = false;
  static String loadingPanel = "0/0";
  static List<ValueItem> itemsML = [];
  static List<ValueItem> remarks = [];
}
