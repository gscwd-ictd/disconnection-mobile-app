import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:diconnection/src/core/enums/auth/auth_level.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/presentation/view/assigned_team_accounts/assigned_team_accounts.dart';
import 'package:diconnection/src/presentation/view/disconnected_accounts_screen/disconnected_accounts_screen.dart';
import 'package:diconnection/src/presentation/view/dispatch_account_screen/dispatch_account_screen.dart';
import 'package:diconnection/src/presentation/view/monitor_dispatch_screen/monitor_dispatch_screen.dart';
import 'package:diconnection/src/presentation/widget/dashboard_item_widget.dart';
import 'package:sizer/sizer.dart';

class DashBoardScreen extends StatefulWidget {
  final bool isTeam;
  final String? teamName;
  const DashBoardScreen(
      {Key? key,
      required this.isTeam,
      this.teamName})
      : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    bool isTeam = widget.isTeam;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isTeam
              ? [
                  DashBoardItemWidget(
                    icondata: FontAwesomeIcons.usersGear,
                    title: "ASSIGNED ACCOUNTS",
                    onPressedFunction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const AssignedTeamAccounts(auth:  AuthLevel.Team1,)));
                    },
                  ),
                  SizedBox(height: 3.0.h),
                  DashBoardItemWidget(
                    icondata: FontAwesomeIcons.ban,
                    title: "DISCONNECTED ACCOUNTS",
                    onPressedFunction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const DisconnectedAccountScreen()));
                    },
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                ]
              : [
                  DashBoardItemWidget(
                    icondata: FontAwesomeIcons.userTag,
                    title: "DISPATCH ACCOUNTS",
                    onPressedFunction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const DispatchAccountScreen()));
                    },
                  ),
                  SizedBox(height: 3.0.h),
                  DashBoardItemWidget(
                    icondata: FontAwesomeIcons.ban,
                    title: "DISCONNECTED ACCOUNTS",
                    onPressedFunction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const DisconnectedAccountScreen()));
                    },
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  DashBoardItemWidget(
                    icondata: FontAwesomeIcons.userGear,
                    title: "MONITOR DISPATCH TEAM",
                    onPressedFunction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MonitorDispatchScreen()));
                    },
                  )
                ],
        ),
      ),
    );
  }
}
