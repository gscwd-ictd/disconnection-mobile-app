import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diconnection/main.dart';
import 'package:diconnection/overlay.dart';
import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/core/messages/error_message/error_message.dart';
import 'package:diconnection/src/core/messages/success_message/success_message.dart';
import 'package:diconnection/src/core/messages/warning_message/warning_message.dart';
import 'package:diconnection/src/data/models/login_model/login_model.dart';
import 'package:diconnection/src/data/services/auth_provider/auth_provider.dart';
import 'package:diconnection/src/presentation/view/login_screen/authState.dart';
import 'package:diconnection/src/presentation/view/zone_assigned_screen/zone_assigned_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final userText = TextEditingController();
  final passText = TextEditingController();
  final urlText = TextEditingController();
  late StreamController<int> _events;

  Color _passwordStat = Colors.red;
  bool _hidePassword = true;

  @override
  void initState() {
    // TODO: implement initState
    _events = StreamController<int>();
    userText.clear();
    passText.clear();
    super.initState();
  }

  void _hidePass() {
    setState(() {
      if (_hidePassword) {
        _hidePassword = false;
        _passwordStat = Colors.grey;
      } else {
        _hidePassword = true;
        _passwordStat = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(asyncAuthProvider);
    _events = StreamController<int>();
    // return auth ? const ZoneAssignedScreen() : loginForm(context);
    return SafeArea(
        child: Scaffold(
      appBar: null,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.lightBlue,
      floatingActionButton: !isDebug
          ? null
          : FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(
                            "SET HOST API URL",
                            textAlign: TextAlign.center,
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.w900),
                          ),
                          actions: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: 40.w,
                                        child: TextField(controller: urlText)),
                                    TextButton(
                                      onPressed: () {
                                        UtilsHandler.apiLink = urlText.text;
                                        Navigator.pop(context);
                                      },
                                      child: const Text('SAVE'),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ));
              },
              child: const Icon(Icons.settings)),
      body: switch (auth) {
        AsyncData(:final value) =>
          value == 0 ? loginForm(context) : const ZoneAssignedScreen(),
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncError(:final error) => Text('Error $error'),
        _ => const Center(child: CircularProgressIndicator())
      },
    ));
  }

  Padding loginForm(BuildContext context) {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //GSCWD Logo
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 28.0.h,
                    width: 100.0.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                              "assets/images/main_logo_bg_white.png")),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: TextFormField(
                  scrollPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).viewInsets.bottom + 5),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      userText.clear();
                      return 'Please enter some text';
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: userText,
                  decoration: InputDecoration(
                      fillColor: kWhiteColor,
                      filled: true,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleUser,
                          // color: Colors.black54,
                        ),
                      ),
                      prefixIconColor: kBackgroundColor,
                      hintText: "Username",
                      // hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: TextFormField(
                  scrollPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).viewInsets.bottom),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      passText.clear();
                      return 'Please enter some text';
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passText,
                  decoration: InputDecoration(
                    fillColor: kWhiteColor,
                    filled: true,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: FaIcon(FontAwesomeIcons.lock),
                    ),
                    prefixIconColor: kBackgroundColor,
                    hintText: "Password",
                    // hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        _hidePass();
                      },
                    ),
                  ),
                  obscureText: _hidePassword,
                ),
              ),
              const SizedBox(height: 20.0),
              StreamBuilder<int>(
                  initialData: 1,
                  stream: _events.stream,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    switch (snapshot.data!) {
                      case 0:
                        return const CircularProgressIndicator();
                      case 1:
                        return loginButton(context);
                      default:
                        return loginButton(context);
                    }
                  }),
              const SizedBox(height: 20.0),
            ],
          ),
        ));
  }

  ElevatedButton loginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          shadowColor: Colors.black38,
          elevation: 3,
          minimumSize: const Size(305, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      // ButtonStyle(
      //     backgroundColor: MaterialStateProperty.all(kLightBlue),
      //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(5.0)))),
      onPressed: () async {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult[0] == ConnectivityResult.mobile ||
            connectivityResult[0] == ConnectivityResult.wifi ||
            connectivityResult[0] == ConnectivityResult.ethernet) {
          LoginM a = LoginM(password: passText.text, username: userText.text);
          // ignore: use_build_context_synchronously
          ref
              .read(asyncAuthProvider.notifier)
              .login(a, _events, context)
              .then((c) => {passText.clear()});
        } else {
          // ignore: use_build_context_synchronously
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => ErrorMessage(
                    content: 'Please connect to your wifi or mobile data',
                    onPressedFunction: () {
                      Navigator.pop(context);
                    },
                    title: 'No Internet Connection',
                  ));
        }
      },
      child: Text('LOGIN',
          style: TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp)),
    );
    // child: Padding(
    //   // padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
    //   padding: EdgeInsets.symmetric(horizontal: 5.w),
    //   child: Text('LOGIN',
    //       style: TextStyle(
    //           color: kWhiteColor,
    //           fontWeight: FontWeight.bold,
    //           fontSize: 14.sp)),
    // ));
  }
}
