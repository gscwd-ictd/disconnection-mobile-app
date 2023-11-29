import 'package:flutter/material.dart';
import 'package:diconnection/src/core/enums/auth/auth_level.dart';
import 'package:diconnection/src/core/handler/checkBoxHandler/checkBoxHandler.dart';
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
  State<ConsumerAccountItemWidget> createState() => _ConsumerAccountItemWidgetState();
}

class _ConsumerAccountItemWidgetState extends State<ConsumerAccountItemWidget> {
  @override
  Widget build(BuildContext context) {
    ConsumerModel consumerData = widget.consumerData;
    bool stats = consumerData.isConnected ?? false;
    return GestureDetector(
      onTap: (){
        widget.onPressedFunction();
      },
      child: Card(
        elevation: 12.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    widget.isDiconnected ? Container() : Checkbox(
                      activeColor: kLightBlue,
                      value: CheckBoxHandler.distributeSelected[widget.index], 
                      onChanged: (val){
                        setState(() {
                          CheckBoxHandler.distributeSelected[widget.index] = val!;
                        });
                      }),
                    Column(
                      children: [
                        const Text("Consumer Name: "),
                        Text(
                          consumerData.consumerName ?? "",
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 14.sp, 
                            fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(width: 14.w,),
                    Column(
                      children: [
                        const Text("Unpaid: "),
                        Text(
                          "P${consumerData.billAmount ?? 0.00}",
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14.sp, 
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
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => !stats ? ConsumerDetailDisconnected(consumerData: consumerData, index: widget.index, onPressedFunction: (){},) : ConsumerDetailForDisconnect(consumerData: consumerData, index: 0, onPressedFunction: (){},)));
                },
                child: Text(
                      "Show more...",
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: kLightBlue),
                      textAlign: TextAlign.center,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}