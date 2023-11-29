import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/presentation/widget/consumer_account_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class DisconnectedScreen extends ConsumerStatefulWidget {
  final List<ConsumerModel> consumerList;
  const DisconnectedScreen({Key? key, required this.consumerList}) : super(key: key);

  @override
  ConsumerState<DisconnectedScreen> createState() => _DisconnectedScreenState();
}

class _DisconnectedScreenState extends ConsumerState<DisconnectedScreen> {
  TextEditingController txtSearch = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var consumerList = widget.consumerList;
    return 
          Padding(
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
                        child:ListView.builder(
                          shrinkWrap: true,
                          itemCount: txtSearch.text == ""
                              ? consumerList.length
                              : consumerList.length,
                          itemBuilder: (context, index) {
                            return ConsumerAccountItemWidget(
                              consumerData: txtSearch.text == ""
                                  ? consumerList[index]
                                  : consumerList[index],
                              index: index,
                              onPressedFunction: () {},
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0.sp),
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