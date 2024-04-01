import 'dart:async';

import 'package:diconnection/src/core/enums/status/status_enum.dart';
import 'package:diconnection/src/core/messages/error_message/error_message.dart';
import 'package:diconnection/src/core/messages/success_message/success_message.dart';
import 'package:diconnection/src/core/messages/verifying_messgae/verifying_message.dart';
import 'package:diconnection/src/core/messages/warning_message/proceed_message.dart';
import 'package:diconnection/src/data/services/disconnection_provider/disconnection_provider.dart';
import 'package:flutter/material.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/presentation/widget/consumer_detail_for_disconnect.dart';
import 'package:diconnection/src/presentation/widget/consumer_detail_disconnected.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class ConsumerAccountItemWidget extends ConsumerStatefulWidget {
  final int index;
  final ConsumerModel consumerData;
  final Function onPressedFunction;
  final bool isDiconnected;
  const ConsumerAccountItemWidget(
      {Key? key,
      required this.consumerData,
      required this.onPressedFunction,
      required this.index,
      required this.isDiconnected})
      : super(key: key);

  @override
  ConsumerState<ConsumerAccountItemWidget> createState() =>
      _ConsumerAccountItemWidgetState();
}

class _ConsumerAccountItemWidgetState
    extends ConsumerState<ConsumerAccountItemWidget> {
  late StreamController<int> _events;
  @override
  void initState() {
    // TODO: implement initState
    _events = StreamController<int>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConsumerModel consumerData = widget.consumerData;
    String accountNo = consumerData.accountNo.toString();
    String consumerName = fixText(consumerData.consumerName!, limit: 16);
    bool stats = consumerData.isConnected ?? false;
    String refresh = '';
    double a = double.parse(consumerData.billAmount!);
    return GestureDetector(
      onTap: () async {
        _events = StreamController<int>();
        if (stats) {
          ref
              .read(asyncDisconnectionProvider.notifier)
              .verify(consumerData, _events);
          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => StreamBuilder<int>(
                  initialData: 0,
                  stream: _events.stream,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    switch (snapshot.data!) {
                      case 0:
                        return VerifyingMessage(
                          content: 'Verifying:',
                          onPressedFunction: () {},
                          state: snapshot.data!,
                          success: 1,
                          title: '',
                        );
                      case 200:
                        return ProceedMessage(
                            title: 'Not Paid ',
                            content: '${consumerName} has not paid yet',
                            function: () async {
                              Navigator.pop(context);
                              refresh = await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConsumerDetailForDisconnect(
                                                consumerData: consumerData,
                                                index: 0,
                                                onPressedFunction: () {},
                                              ))) ??
                                  "";
                              if (refresh == 'refresh') {
                                widget.onPressedFunction();
                              }
                            });
                      case 300:
                        return ProceedMessage(
                            title: 'No Internet ',
                            content:
                                '$consumerName not verified if paid or not. Please call to verify',
                            function: () async {
                              Navigator.pop(context);
                              refresh = await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConsumerDetailForDisconnect(
                                                consumerData: consumerData,
                                                index: 0,
                                                onPressedFunction: () {},
                                              ))) ??
                                  "";
                              if (refresh == 'refresh') {
                                widget.onPressedFunction();
                              }
                            });
                      case 400:
                        return SuccessMessage(
                          title: "Already Paid",
                          content:
                              "Please abort disconnection the Consumer was already paid",
                          onPressedFunction: () {
                            Navigator.pop(context, 'refresh');
                            setState(() {});
                          },
                        );
                      case 401: //Failed to Verify Please try again
                        return ErrorMessage(
                          title: 'Expired Session',
                          content: 'Please login again.',
                          onPressedFunction: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                      case 500: //Failed to Verify Please try again
                        return ErrorMessage(
                          title: 'Please try again',
                          content: 'Failed to Verify Please try again',
                          onPressedFunction: () {
                            Navigator.pop(context);
                          },
                        );
                      default:
                        return ErrorMessage(
                          title: 'Please try again',
                          content: 'There is error',
                          onPressedFunction: () {
                            Navigator.pop(context);
                          },
                        );
                    }
                  }));
        } else {
          refresh = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => !stats
                      ? ConsumerDetailDisconnected(
                          consumerData: consumerData,
                          index: widget.index,
                          onPressedFunction: () {},
                        )
                      : ConsumerDetailForDisconnect(
                          consumerData: consumerData,
                          index: 0,
                          onPressedFunction: () {},
                        ))) ??
              "";
          if (refresh == 'refresh') {
            widget.onPressedFunction();
          }
        }
      },
      child: Card(
        color: getStatus(consumerData.status!) == StatusEnum.cancelled
            ? Colors.red[100]
            : null,
        elevation: 12.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 18.0, bottom: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 70.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                accountNo,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                ' $consumerName',
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Text(
                            consumerData.address!,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w300),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: consumerName.length >= 22 ? 10.w : 12.w,
                    ),
                    const Column(
                      children: [
                        Text("Unpaid: "),
                        Text("SeqNo: "),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "P${a.toStringAsFixed(2)}",
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          consumerData.seqNo.toString(),
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              // GestureDetector(
              //   onTap: () async {
              //     String? refresh =
              //         await Navigator.of(context).push(MaterialPageRoute(
              //                 builder: (context) => !stats
              //                     ? ConsumerDetailDisconnected(
              //                         consumerData: consumerData,
              //                         index: widget.index,
              //                         onPressedFunction: () {},
              //                       )
              //                     : ConsumerDetailForDisconnect(
              //                         consumerData: consumerData,
              //                         index: 0,
              //                         onPressedFunction: () {},
              //                       ))) ??
              //             "";
              //     if (refresh == 'refresh') {
              //       widget.onPressedFunction();
              //     }
              //   },
              //   child: Container(
              //     width: 90.w,
              //     height: 3.h,
              //     child: Text(
              //       "Show more...",
              //       softWrap: true,
              //       style: TextStyle(
              //           fontSize: 10.sp,
              //           fontWeight: FontWeight.bold,
              //           color: getStatus(consumerData.status!) ==
              //                   StatusEnum.cancelled
              //               ? kBackgroundColor
              //               : kLightBlue),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  StatusEnum getStatus(int input) {
    switch (input) {
      case 0:
        return StatusEnum.ongoing;
      case 1:
        return StatusEnum.done;
      case 2:
        return StatusEnum.cancelled;
      case 3:
        return StatusEnum.mlOngoing;
      case 4:
        return StatusEnum.mlDone;
      default:
        return StatusEnum.ongoing;
    }
  }
}
