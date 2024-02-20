import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/data/models/super_user_model/super_user_hive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/presentation/view/login_screen/login_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  await Hive.initFlutter();
  const permission = Permission.location;
  if (await permission.isDenied) {
    await permission.request();
  }
  Hive.registerAdapter(SuperUserHiveAdapter());
  // Hive.registerAdapter(CategoryAdapter());

  await Hive.openBox('superUser');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  bool initConState = false;
  final snackBar = SnackBar(
    content: const Text('Yay! A SnackBar!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  @override
  Widget build(BuildContext context) {
    //Prevent from Landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return StreamBuilder<Object>(
            initialData: Connectivity().checkConnectivity(),
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              final connectivityResult = snapshot.data;
              if (connectivityResult == ConnectivityResult.none ||
                  connectivityResult == null) {
                const SnackBar snackBar =
                    SnackBar(content: Text("No Internet Connection"));
                snackbarKey.currentState?.showSnackBar(snackBar);
                UtilsHandler.hasConnection = false;
                initConState = true;
              } else {
                if (initConState) {
                  SnackBar snackBar = const SnackBar(
                      backgroundColor: Colors.greenAccent,
                      content: Text(
                        "Connection Restored",
                        style: TextStyle(color: Colors.black),
                      ));
                  snackbarKey.currentState?.showSnackBar(snackBar);
                }
                UtilsHandler.hasConnection = true;
              }
              return MaterialApp(
                scaffoldMessengerKey: snackbarKey,
                scrollBehavior: const MaterialScrollBehavior().copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch,
                    PointerDeviceKind.stylus,
                    PointerDeviceKind.unknown
                  },
                ),
                debugShowCheckedModeBanner: false,
                home: const MyHomePage(title: 'Flutter Demo Home Page'),
                title: kMaterialAppTitle,
              );
            });
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const Login();
  }
}
