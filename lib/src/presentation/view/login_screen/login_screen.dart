import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diconnection/src/core/messages/error_message/error_message.dart';
import 'package:diconnection/src/presentation/view/login_screen/authState.dart';
import 'package:diconnection/src/presentation/view/zone_assigned_screen/zone_assigned_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:sizer/sizer.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final userText = TextEditingController();
  final passText = TextEditingController();

  Color _passwordStat = Colors.red;
  bool _hidePassword = true;

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
    final auth = ref.watch(authNotifierProvider);
    return auth
        ? const ZoneAssignedScreen()
        : SafeArea(
            child: Scaffold(
              appBar: null,
              resizeToAvoidBottomInset: false,
              backgroundColor: kWhiteColor,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30.0.h,
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
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: TextFormField(
                      scrollPadding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        5),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          userText.clear();
                          return 'Please enter some text';
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: userText,
                      decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: FaIcon(FontAwesomeIcons.solidCircleUser),
                          ),
                          prefixIconColor: kBackgroundColor,
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: TextFormField(
                      scrollPadding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        5),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          passText.clear();
                          return 'Please enter some text';
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passText,
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: FaIcon(FontAwesomeIcons.lock),
                        ),
                        prefixIconColor: kBackgroundColor,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        suffixIcon: IconButton(
                          icon:
                              Icon(Icons.remove_red_eye, color: _passwordStat),
                          onPressed: _hidePass,
                        ),
                      ),
                      obscureText: _hidePassword,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kLightBlue),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)))),
                      onPressed: () async {
                        var connectivityResult = await (Connectivity().checkConnectivity());
                        if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
                          ref.read(authNotifierProvider.notifier).login();
                        }else{
                          // ignore: use_build_context_synchronously
                          showDialog(
                            barrierDismissible: false,
                            context: context, 
                            builder: (context) => ErrorMessage(
                              content: 'Please connect to your wifi or mobile data',
                              onPressedFunction: (){ Navigator.pop(context);}, 
                              title: 'No Internet Connection',
                            ));
                        }
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const ZoneAssignedScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: Text('LOGIN',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp)),
                      )),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          );
  }
}
