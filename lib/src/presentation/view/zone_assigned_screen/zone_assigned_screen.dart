import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/mock/zones_mock.dart';
import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:diconnection/src/data/services/auth_provider/auth_provider.dart';
import 'package:diconnection/src/data/services/disconnection_provider/disconnection_provider.dart';
import 'package:diconnection/src/presentation/view/login_screen/authState.dart';
import 'package:diconnection/src/presentation/widget/Zone_item_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class ZoneAssignedScreen extends ConsumerStatefulWidget {
  const ZoneAssignedScreen({super.key});

  @override
  ConsumerState<ZoneAssignedScreen> createState() => _ZoneAssignedScreenState();
}

class _ZoneAssignedScreenState extends ConsumerState<ZoneAssignedScreen> {
  TextEditingController txtSearch = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late EasyRefreshController _controller;

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
              onPressed: () {
                ref.read(asyncAuthProvider.notifier).isExpired();
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 10.0),
            child: Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 70.0.w,
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        // _alterfilter(val);
                      });
                    },
                    controller: txtSearch,
                    style: TextStyle(fontSize: 12.0.sp, color: Colors.black),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            borderSide: BorderSide(
                                color: Colors.black, style: BorderStyle.solid)),
                        hintText: "Search here",
                        hintStyle:
                            TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                        fillColor: kWhiteColor,
                        filled: true),
                    enabled: true,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SizedBox(
              height: 77.h,
              width: 100.w,
              child: Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: EasyRefresh(
                    controller: _controller,
                    header: const ClassicHeader(),
                    onRefresh: () async {
                      await ref
                          .read(asyncDisconnectionProvider.notifier)
                          .refresh();
                      _controller.finishRefresh();
                    },
                    child: SizedBox(
                      height: 77.h,
                      child: switch (disconnection) {
                        AsyncData(:final value) => value.isEmpty
                            ? const Center(child: Text("Empty"))
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
            ),
          ),
        ],
      ),
    );
  }
}
