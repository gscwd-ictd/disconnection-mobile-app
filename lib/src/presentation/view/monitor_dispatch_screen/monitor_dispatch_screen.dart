import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:putulinmo/src/core/utils/constants.dart';
import 'package:putulinmo/src/presentation/view/monitor_dispatch_screen/team_assignment_screen/team_assignment_screen.dart';
import 'package:putulinmo/src/presentation/widget/dashboard_item_widget.dart';
import 'package:sizer/sizer.dart';

class MonitorDispatchScreen extends StatefulWidget {
  const MonitorDispatchScreen({super.key});

  @override
  State<MonitorDispatchScreen> createState() => _MonitorDispatchScreenState();
}

class _MonitorDispatchScreenState extends State<MonitorDispatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kScaffoldColor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DashBoardItemWidget(
                      icondata: FontAwesomeIcons.users,
                      title: "TEAM 1",
                      onPressedFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const TeamAssignmentScreen()));
                      },
                    ),
                    DashBoardItemWidget(
                      icondata: FontAwesomeIcons.users,
                      title: "TEAM 2",
                      onPressedFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const TeamAssignmentScreen()));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 2.0.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DashBoardItemWidget(
                      icondata: FontAwesomeIcons.users,
                      title: "TEAM 3",
                      onPressedFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const TeamAssignmentScreen()));
                      },
                    ),
                    DashBoardItemWidget(
                      icondata: FontAwesomeIcons.users,
                      title: "TEAM 4",
                      onPressedFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const TeamAssignmentScreen()));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 2.0.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DashBoardItemWidget(
                      icondata: FontAwesomeIcons.users,
                      title: "TEAM 5",
                      onPressedFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const TeamAssignmentScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
