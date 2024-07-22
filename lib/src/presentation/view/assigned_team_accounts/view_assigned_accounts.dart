import 'dart:convert';

import 'package:diconnection/src/core/enums/status/status_enum.dart';
import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/data/models/offline_disconnection_hive_model/offline_disconnection_hive_model.dart';
import 'package:diconnection/src/data/services/auth_provider/auth_provider.dart';
import 'package:diconnection/src/data/services/disconnection_provider/disconnection_provider.dart';
import 'package:diconnection/src/presentation/view/assigned_team_accounts/disconnected_screen.dart/disconnected_screen.dart';
import 'package:diconnection/src/presentation/view/assigned_team_accounts/for_disconnect_screen.dart/for_disconnect_screen.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';

class AssignedAccounts extends ConsumerStatefulWidget {
  final String address;
  final List<ConsumerModel> consumerList;
  final int index;
  const AssignedAccounts(
      {Key? key,
      required this.consumerList,
      required this.address,
      required this.index})
      : super(key: key);

  @override
  ConsumerState<AssignedAccounts> createState() => _AssignedAccountsState();
}

class _AssignedAccountsState extends ConsumerState<AssignedAccounts> {
  TextEditingController txtSearch = TextEditingController();
  final PageController pageController = PageController();
  List<ConsumerModel> consumerList = [];
  bool isSecondPage = false;
  late EasyRefreshController _controller;

  @override
  void initState() {
    // TODO: implement initState
    isSecondPage = false;
    pageController.initialPage;
    consumerList = UtilsHandler.zones[widget.index].consumerList;
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    super.initState();
  }

  Future<String> fordelayed() async {
    return await Future.delayed(const Duration(seconds: 1), () => "Hello");
  }

  @override
  Widget build(BuildContext context) {
    if (UtilsHandler.zones.isEmpty) {
      Navigator.pop(context, 'refresh');
    } else {
      consumerList = UtilsHandler.zones.isNotEmpty
          ? UtilsHandler.zones[widget.index].consumerList
          : [];
    }
    var forDiscon = consumerList
        .where((c) =>
            c.consumerName!
                .toUpperCase()
                .contains(txtSearch.text.toUpperCase()) &&
            (c.status == StatusEnum.ongoing.getIntVal ||
                c.status == StatusEnum.cancelled.getIntVal ||
                c.status == StatusEnum.mlOngoing.getIntVal))
        .toList();
    var disconnected = consumerList
        .where((c) =>
            c.consumerName!
                .toUpperCase()
                .contains(txtSearch.text.toUpperCase()) &&
            (c.status == StatusEnum.done.getIntVal ||
                c.status == StatusEnum.mlDone.getIntVal))
        .toList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: kScaffoldColor,
        title:
            Text(widget.address, style: const TextStyle(color: Colors.white)),
      ),
      body: StatefulBuilder(builder: (lowerContext, innerSetState) {
        return Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  onChanged: (val) {
                    setState(() {});
                  },
                  controller: txtSearch,
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid)),
                    hintText: "Search here",
                    hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  enabled: true,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 12.0, left: 10.0),
            //   child: Row(
            //     col
            //   ),
            // ),
            EasyRefresh(
              controller: _controller,
              header: const ClassicHeader(),
              onRefresh: () async {
                if (UtilsHandler.isAvailableToSync || !UtilsHandler.doneSync) {
                  print('you cant refresh');
                } else {
                  print('refreshing');
                  await ref
                      .read(asyncAuthProvider.notifier)
                      .refresh()
                      .then((value) => () async {
                            await ref
                                .read(asyncDisconnectionProvider.notifier)
                                .refresh();
                          });
                  setState(() {});
                }
                _controller.finishRefresh();
              },
              child: SizedBox(
                  height: 70.h,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                      ForDisconnectScreen(
                        consumerList: forDiscon,
                        onPressedFunction: () {
                          Future.delayed(const Duration(milliseconds: 100), () {
                            setState(() {});
                          });
                        },
                      ),
                      DisconnectedScreen(
                        consumerList: disconnected,
                        onPressedFunction: () {
                          Future.delayed(const Duration(milliseconds: 100), () {
                            setState(() {});
                          });
                        },
                      )
                    ],
                  )),
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                      if (pageController.page != 0) {
                        isSecondPage = !isSecondPage;
                      }
                      setState(() {});
                    },
                    child: SizedBox(
                        width: 49.w,
                        height: 8.h,
                        child: Card(
                            color: !isSecondPage
                                ? kBackgroundColor
                                : Colors.grey[300],
                            child: Center(
                                child: Text("For Disconnection",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: isSecondPage
                                            ? Colors.black
                                            : Colors.white)))))),
                GestureDetector(
                    onTap: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                      if (pageController.page != 1) {
                        isSecondPage = !isSecondPage;
                      }
                      setState(() {});
                    },
                    child: SizedBox(
                        width: 49.w,
                        height: 8.h,
                        child: Card(
                            color: isSecondPage
                                ? kBackgroundColor
                                : Colors.grey[300],
                            child: Center(
                                child: Text("Disconnected",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: !isSecondPage
                                            ? Colors.black
                                            : Colors.white))))))
              ],
            )
          ],
        );
      }),
    );
  }
}
