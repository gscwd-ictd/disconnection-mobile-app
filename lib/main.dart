import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/presentation/view/login_screen/login_screen.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async{
  await Hive.initFlutter();

  // Hive.registerAdapter(RegistrationAdapter());
  // Hive.registerAdapter(CategoryAdapter());

  await Hive.openBox('registration');
  await Hive.openBox('category');
  runApp(const MyApp());
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
            title: kMaterialAppTitle,
          );
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
    //return DistributeAccountDetail(consumerData: ConsumerMockData.consumerList[0], icondata: Icons.abc, index: 0, onPressedFunction: (){},);
  }
}
