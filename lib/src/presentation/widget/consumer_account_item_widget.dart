import 'package:diconnection/src/core/enums/status/status_enum.dart';
import 'package:flutter/material.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/presentation/widget/consumer_detail_for_disconnect.dart';
import 'package:diconnection/src/presentation/widget/consumer_detail_disconnected.dart';
import 'package:sizer/sizer.dart';

class ConsumerAccountItemWidget extends StatefulWidget {
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
  State<ConsumerAccountItemWidget> createState() =>
      _ConsumerAccountItemWidgetState();
}

class _ConsumerAccountItemWidgetState extends State<ConsumerAccountItemWidget> {
  @override
  Widget build(BuildContext context) {
    ConsumerModel consumerData = widget.consumerData;
    String accountNo = consumerData.accountNo.toString();
    String consumerName = fixText(consumerData.consumerName!, limit: 16);
    bool stats = consumerData.isConnected ?? false;
    return GestureDetector(
      onTap: () async {
        String? refresh = await Navigator.of(context).push(MaterialPageRoute(
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
                          "P${consumerData.billAmount ?? 0.00}",
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
              GestureDetector(
                onTap: () async {
                  String? refresh =
                      await Navigator.of(context).push(MaterialPageRoute(
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
                },
                child: Container(
                  width: 90.w,
                  height: 3.h,
                  child: Text(
                    "Show more...",
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: getStatus(consumerData.status!) ==
                                StatusEnum.cancelled
                            ? kBackgroundColor
                            : kLightBlue),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
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
