import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


const String kHost = "c054-122-3-104-117.ngrok-free.app";

const String kMaterialAppTitle = 'Putulin Mo';
const String bingMapKey = "AhkEgNbLCfEkDksb2EQrhwYphgbfAbwcF6OR4Pexem68p8t_9nWeTeVAHOfC0eEd";

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
