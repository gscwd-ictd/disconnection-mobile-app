import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diconnection/overlay.dart';
import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_hive_model.dart';
import 'package:diconnection/src/data/models/lib_zones_model/lib_zones_hive_model.dart';
import 'package:diconnection/src/data/models/member_model/member_hive_model.dart';
import 'package:diconnection/src/data/models/offline_disconnection_hive_model/offline_disconnection_hive_model.dart';
import 'package:diconnection/src/data/models/proof_of_disconnection_model/proof_of_disconnection_hive_model.dart';
import 'package:diconnection/src/data/models/super_user_model/super_user_hive_model.dart';
import 'package:diconnection/src/data/models/team_model/team_hive_model.dart';
import 'package:diconnection/src/data/services/sync_provider/sync_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/presentation/view/login_screen/login_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

OverlayScreen? overlayScreen;

Future<void> main() async {
  await Hive.initFlutter();
  const permission = Permission.location;
  if (await permission.isDenied) {
    await permission.request();
    if (await permission.isDenied) {
      exit(0);
    }
  }
  Hive.registerAdapter(SuperUserHiveAdapter());
  Hive.registerAdapter(OfflineDisconnectionHiveAdapter());
  Hive.registerAdapter(ConsumerHiveAdapter());
  Hive.registerAdapter(LibZonesHiveAdapter());
  Hive.registerAdapter(TeamHiveAdapter());
  Hive.registerAdapter(MemberHiveAdapter());
  Hive.registerAdapter(ProofOfDisconnectionHiveAdapter());
  await Hive.openBox('superUser');
  await Hive.openBox('offlineDisconnection');
  await Hive.openBox('consumer');
  await Hive.openBox('libZones');
  await Hive.openBox('team');
  await Hive.openBox('member');
  await Hive.openBox('proofs');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Prevent from Landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
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
          theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(),
          ),
          title: kMaterialAppTitle,
        );
      },
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
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
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Offset _offset = Offset.zero;
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
    Timer.run(() => showOverlay(context));
    final synchingWatch = ref.watch(asyncSyncProvider);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: StreamBuilder<Object>(
            initialData: Connectivity().checkConnectivity(),
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              final connectivityResult = snapshot.data;
              if (connectivityResult == ConnectivityResult.mobile ||
                  connectivityResult == ConnectivityResult.wifi ||
                  connectivityResult == ConnectivityResult.ethernet) {
                //ONLINE REGION
                if (UtilsHandler.isAvailableToSync) {
                  Timer.run(
                      () => ref.read(asyncSyncProvider.notifier).syncAll());
                }
                if (initConState) {
                  SnackBar snackBar = const SnackBar(
                      backgroundColor: Colors.greenAccent,
                      content: Text(
                        "Connection Restored",
                        style: TextStyle(color: Colors.black),
                      ));
                  Timer.run(() =>
                      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                          .showSnackBar(snackBar));
                }
                UtilsHandler.hasConnection = true;
              } else {
                //OFLINE REGION
                const SnackBar snackBar =
                    SnackBar(content: Text("No Internet Connection"));
                Timer.run(() =>
                    ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                        .showSnackBar(snackBar));
                UtilsHandler.hasConnection = false;
                initConState = true;
              }
              return const Login();
            }),
      ),
    );
  }

  void showOverlay(BuildContext context) {
    int num = 0;
    bool isTimer = false;
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => StatefulBuilder(builder: (context, innerSetState) {
        num = num < 100 ? num + 1 : num;
        if (!isTimer) {
          Timer.periodic(
              const Duration(seconds: 5), (Timer t) => innerSetState(() {}));
          isTimer = true;
          print('Timer executed');
        }
        return UtilsHandler.isAvailableToSync
            ? Positioned(
                top: 30,
                right: 50,
                child: Material(
                  elevation: 4,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    color: getColor(),
                    child: Row(
                      children: [
                        Text(
                          UtilsHandler.loadingPanel,
                          style: TextStyle(fontSize: 8.sp),
                        ),
                        UtilsHandler.doneSync
                            ? Container()
                            : SizedBox(
                                height: 2.0.h,
                                width: 3.0.w,
                                child: const CircularProgressIndicator())
                      ],
                    ),
                  ),
                ),
              )
            : Container();
      }),
    );

    Overlay.of(context).insert(overlayEntry);

    // To remove the overlay after some time (e.g., 3 seconds)
    // Future.delayed(Duration(seconds: 3), () {
    //   overlayEntry.remove();
    // });
  }

  Color getColor() {
    Color output = Colors.amber;
    bool hasAvailable = UtilsHandler.isAvailableToSync;
    bool doneSync = UtilsHandler.doneSync;
    if (hasAvailable && doneSync) {
      output = Colors.amber;
    }
    if (hasAvailable && !doneSync) {
      output = Colors.lightGreenAccent;
    }
    return output;
  }
}
