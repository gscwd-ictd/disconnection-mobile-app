import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/presentation/view/dashboard_screen/dashboard_screen.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: Text('LogIn',
            style: TextStyle(color: Colors.white, fontSize: 15.0.sp)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: TextFormField(
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
                  prefixIconColor: kWhiteColor,
                  hintText: "Username",
                  hintStyle: const TextStyle(color: kWhiteColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: TextFormField(
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
                prefixIconColor: kWhiteColor,
                hintText: "Password",
                hintStyle: const TextStyle(color: kWhiteColor),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye, color: _passwordStat),
                  onPressed: _hidePass,
                ),
              ),
              obscureText: _hidePassword,
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)))),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const DashBoardScreen(isTeam: false)));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Log in', style: TextStyle(color: Colors.black)),
              )),
          const SizedBox(height: 20.0),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)))),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const DashBoardScreen(isTeam: true, teamName: "Team1",)));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Log in as TEAM 1', style: TextStyle(color: Colors.black)),
              )),
        ],
      ),
    );
  }
}
