import 'dart:async';

import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/core/messages/reminder_message/reminder_message.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/mock/zones_mock.dart';
import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:diconnection/src/data/services/auth_provider/auth_provider.dart';
import 'package:diconnection/src/data/services/disconnection_provider/disconnection_provider.dart';
import 'package:diconnection/src/presentation/widget/Zone_item_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/widgets/hint_text.dart';
import 'package:sizer/sizer.dart';

class ZoneAssignedScreen extends ConsumerStatefulWidget {
  const ZoneAssignedScreen({super.key});

  @override
  ConsumerState<ZoneAssignedScreen> createState() => _ZoneAssignedScreenState();
}

class _ZoneAssignedScreenState extends ConsumerState<ZoneAssignedScreen> {
  TextEditingController txtSearch = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late EasyRefreshController _controller;

  Future<String> refresh() async {
    String output = "";
    return output;
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final disconnection = ref.watch(asyncDisconnectionProvider);
    List<ZoneModel> zonesData = ZonesMock.zoneList
        .where((c) =>
            c.barangay.toUpperCase().contains(txtSearch.text.toUpperCase()))
        .toList();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kScaffoldColor,
          actions: [
            IconButton(
                color: kWhiteColor,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => ReminderMessage(
                              title: "Logout",
                              content:
                                  "Logging out will halt all ongoing operations. Please confirm your logout to proceed. Remember, any unsaved progress may be lost. Are you sure you want to logout?",
                              textButtons: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ref
                                          .read(asyncAuthProvider.notifier)
                                          .isExpired();
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(fontSize: 16.0.sp),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'No',
                                      style: TextStyle(fontSize: 16.0.sp),
                                    ))
                              ]));
                },
                icon: const Icon(Icons.logout_rounded))
          ],
        ),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: txtSearch,
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          // suffix: HintText(hintText: "Search"),
                          // suffixText: "Search",
                          hintText: "Search here",
                          hintStyle:
                              TextStyle(fontSize: 16.0, color: Colors.grey),
                          fillColor: kWhiteColor,
                          filled: true),
                      enabled: true,
                    ),
                  ),
                ),
                SizedBox(
                  child: Scrollbar(
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      // physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      child: EasyRefresh(
                        controller: _controller,
                        scrollController: _scrollController,
                        header: const ClassicHeader(),
                        onRefresh: () async {
                          if (UtilsHandler.isAvailableToSync ||
                              !UtilsHandler.doneSync) {
                            print('you cant refresh');
                          } else {
                            print('refreshing');
                            await ref
                                .read(asyncAuthProvider.notifier)
                                .refresh()
                                .then((value) => () async {
                                      await ref
                                          .read(asyncDisconnectionProvider
                                              .notifier)
                                          .refresh();
                                    });
                          }
                          // setState(() {});
                          _controller.finishRefresh();
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: switch (disconnection) {
                            AsyncData(:final value) => value.isEmpty
                                ? ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(20.0),
                                        constraints: BoxConstraints(
                                          minHeight: 80.h,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Empty',
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: txtSearch.text == ""
                                        ? value.length
                                        : value.length,
                                    itemBuilder: (context, index) {
                                      return ZoneItemWidget(
                                          zoneData: txtSearch.text == ""
                                              ? value[index]
                                              : value[index],
                                          index: index,
                                          onPressedFunction: () {},
                                          isDiconnected: true);
                                    },
                                  ),
                            AsyncError(:final error) => Text('Error $error'),
                            _ => const Center(child: Text(''))
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
