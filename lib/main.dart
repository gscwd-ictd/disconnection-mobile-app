import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ping/dart_ping.dart';
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
    final ping = Ping('disconnection-api.gscwd.app', timeout: 2, interval: 2);
    // Begin ping process and listen for output
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
    if (!UtilsHandler.isInitialized) {
      Timer.run(() => showOverlay(context));
      UtilsHandler.isInitialized = true;
    } else {
      print('overlay is already running');
    }
    final synchingWatch = ref.watch(asyncSyncProvider);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: StreamBuilder<Object>(
            initialData: Connectivity().checkConnectivity(),
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              try {
                final connectivityResult =
                    snapshot.data as List<ConnectivityResult>;
                if (connectivityResult[0] == ConnectivityResult.mobile ||
                    connectivityResult[0] == ConnectivityResult.wifi ||
                    connectivityResult[0] == ConnectivityResult.ethernet) {
                  //ONLINE REGION
                  print('Running command: ${ping.command}');
                  try {
                    ping.stream.listen((event) {
                      try {
                        UtilsHandler.ping =
                            event.response!.time!.inMilliseconds;
                      } catch (ex) {
                        UtilsHandler.ping = 0;
                      }
                      print(event);
                    });
                  } catch (e) {
                    print(e);
                  }
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
                  UtilsHandler.ping = 0;
                  //OFLINE REGION
                  const SnackBar snackBar =
                      SnackBar(content: Text("No Internet Connection"));
                  Timer.run(() =>
                      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                          .showSnackBar(snackBar));
                  UtilsHandler.hasConnection = false;
                  initConState = true;
                }
              } catch (ex) {
                print(ex);
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
        return Stack(
          children: [
            Positioned(
              top: 30,
              left: 10,
              child: Material(
                color: Colors.transparent,
                child: Row(
                  children: [
                    getPingIcon(),
                    Text(
                      UtilsHandler.ping == 0
                          ? 'No Internet'
                          : '${UtilsHandler.ping.toString()} ms',
                      style: TextStyle(
                          decorationThickness: 2.0,
                          fontSize: 8.sp,
                          color: getPingColor(),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            UtilsHandler.isAvailableToSync
                ? Positioned(
                    top: 30,
                    right: 50,
                    child: Material(
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        color: getSynchColor(),
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
                : Container(),
          ],
        );
      }),
    );

    Overlay.of(context).insert(overlayEntry);

    // To remove the overlay after some time (e.g., 3 seconds)
    // Future.delayed(Duration(seconds: 3), () {
    //   overlayEntry.remove();
    // });
  }

  Color getSynchColor() {
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

  Color getPingColor() {
    Color output = Colors.green;
    int ping = UtilsHandler.ping;
    if (ping > 0 && ping <= 120) {
      output = Colors.green.shade200;
    } else if (ping >= 121 && ping <= 200) {
      output = Colors.yellow;
    } else if (ping >= 201 && ping <= 320) {
      output = Colors.amber;
    } else if (ping >= 321 || ping == 0) {
      output = Colors.red;
    }
    return output;
  }

  executePing() {
    final ping = Ping('122.3.104.117', timeout: 2, interval: 2);
    // [Optional]
    // Preview command that will be run (helpful for debugging)
    // Timer.periodic(const Duration(seconds: 5), (timer) {

    // });
    print('Running command: ${ping.command}');
    // Begin ping process and listen for output
    ping.stream.listen((event) {
      try {
        UtilsHandler.ping = event.response!.time!.inMilliseconds;
      } catch (ex) {
        UtilsHandler.ping = 0;
      }
      print(event);
    });
  }

  Icon getPingIcon() {
    double size = 12.0;
    Icon output = Icon(Icons.signal_wifi_statusbar_4_bar_sharp,
        color: Colors.green.shade200, size: size);
    int ping = UtilsHandler.ping;
    if (ping > 0 && ping <= 120) {
      output = Icon(Icons.signal_wifi_statusbar_4_bar_sharp,
          color: Colors.green.shade200, size: size);
    } else if (ping >= 121 && ping <= 200) {
      output = Icon(Icons.network_wifi_3_bar_sharp,
          color: Colors.yellow, size: size);
    } else if (ping >= 201 && ping <= 320) {
      output =
          Icon(Icons.network_wifi_2_bar_sharp, color: Colors.amber, size: size);
    } else if (ping >= 321 || ping == 0) {
      output = Icon(Icons.signal_wifi_bad_sharp, color: Colors.red, size: size);
    }
    return output;
  }
}
