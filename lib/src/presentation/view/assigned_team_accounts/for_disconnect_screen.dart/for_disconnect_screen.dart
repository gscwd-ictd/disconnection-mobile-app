import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/data/services/disconnection_provider/disconnection_provider.dart';
import 'package:diconnection/src/presentation/widget/consumer_account_item_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class ForDisconnectScreen extends ConsumerStatefulWidget {
  final Function onPressedFunction;
  final List<ConsumerModel> consumerList;
  const ForDisconnectScreen(
      {Key? key, required this.consumerList, required this.onPressedFunction})
      : super(key: key);

  @override
  ConsumerState<ForDisconnectScreen> createState() =>
      _ForDisconnectScreenState();
}

class _ForDisconnectScreenState extends ConsumerState<ForDisconnectScreen> {
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

  Future<String> fordelayed() async {
    return await Future.delayed(const Duration(milliseconds: 0), () => "Hello");
  }

  @override
  Widget build(BuildContext context) {
    var consumerList = widget.consumerList;
    return _forDisconnect(consumerList);
    // return FutureBuilder<String>(
    //     future: fordelayed(),
    //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else {
    //         if (snapshot.hasError) {
    //           return Center(child: Text('Error: ${snapshot.error}'));
    //         } else {
    //           return _forDisconnect(consumerList);
    //         }
    //       }
    //     });
  }

  Padding _forDisconnect(List<ConsumerModel> consumerList) {
    bool last = consumerList.length <= 1;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SizedBox(
        height: 67.h,
        width: 100.w,
        child: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                SizedBox(
                  height: 67.h,
                  child: consumerList.isEmpty
                      ? Center(
                          child: Text(
                          "Empty",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18.sp),
                        ))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: txtSearch.text == ""
                              ? consumerList.length
                              : consumerList.length,
                          itemBuilder: (context, index) {
                            return ConsumerAccountItemWidget(
                              last: last,
                              consumerData: txtSearch.text == ""
                                  ? consumerList[index]
                                  : consumerList[index],
                              index: index,
                              onPressedFunction: widget.onPressedFunction,
                              isDiconnected: true,
                            );
                          },
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 75.w, top: 60.h),
                  child: SizedBox(
                    height: 5.0.h,
                    child: Card(
                        elevation: 12.0,
                        child: Center(
                            child: Text(
                          "Total: ${consumerList.length}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0.sp),
                        ))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
