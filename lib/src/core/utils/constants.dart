import 'package:flutter/material.dart';

const String kHost = "122.3.104.117:8991";
// const String kHost = "172.20.10.23:3000";
const String kHostHttp = "https://172.20.10.23:3000";
const bool isHttp = true;

const String kMaterialAppTitle = 'Disconnection App';
const String bingMapKey =
    "AhkEgNbLCfEkDksb2EQrhwYphgbfAbwcF6OR4Pexem68p8t_9nWeTeVAHOfC0eEd";
const bool isDebug = false;
String kToken = '';

//Colors
const Color kBackgroundColor = Color(0xFF2879C1);
const kScaffoldColor = Color(0xFF2879C1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightBlue = Color(0xFF36CCF7);

///My Theme EDF6E5
const Color primaryMat = Color(0xFFB5EAEA);
const Color primaryMat1 = Color(0xFFE0F3FF);

const Color secondaryMat = Color(0xFFEDF6E5);
const Color thirdMat = Color(0xFFFFBCBC);
const Color fourthMat = Color(0xFFF38BA0);

const kYellowColorLight = Color(0xfaefeeac);
const Color kSettingsBackgroundColor = Color(0xFFdcdedd);

//Screen Size
String getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 600 ? 'phone' : 'tablet';
}

double getScreenSize(BuildContext context) {
  double fullScreenHeight = MediaQuery.of(context).size.height;
  var padding = MediaQuery.of(context).padding;

  var result = fullScreenHeight - padding.top - (fullScreenHeight * 0.28);
  return result;
}

String fixText(String text, {required int limit}) {
  List<String> txtArray = text.split(',');
  bool isMultiArray = txtArray.length > 1;
  String output = '';
  int count = 0;
  for (var a in txtArray) {
    bool isEndArray = txtArray.length == count + 1;
    if (count == 0) {
      output = isMultiArray ? '$a,' : a;
    } else {
      if (!(a.substring(0, 0) == ' ')) {
        output = !isEndArray ? '$output $a,' : '$output $a';
      } else {
        output = !isEndArray ? '$output$a,' : output + a;
      }
    }
    count++;
  }
  output =
      output.length >= limit ? ('${output.substring(0, limit)}...') : output;
  return output;
}

const kAnimationDuration = Duration(milliseconds: 200);
//images for no profile picture
const List<String> knoImagesBoys = [
  'assets/images/boys/1.png',
  'assets/images/boys/2.png',
  'assets/images/boys/3.png',
  'assets/images/boys/4.png',
  'assets/images/boys/5.png',
];

const List<String> knoImagesGirls = [
  'assets/images/girls/1.png',
  'assets/images/girls/2.png',
  'assets/images/girls/3.png',
  'assets/images/girls/4.png',
  'assets/images/girls/5.png',
];

const String kConsolidateDonationsPermission =
    "Pages.Mobile.ConsolidateDonationsFromOfficers";
const String kReceiveDonationsPermission =
    "Pages.Mobile.ReceivedDonationsFromOthers";
