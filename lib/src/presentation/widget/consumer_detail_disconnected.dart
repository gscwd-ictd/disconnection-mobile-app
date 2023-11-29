import 'package:diconnection/src/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:diconnection/src/data/models/disconnect_model.dart';
import 'package:diconnection/src/presentation/widget/consumer_location.dart';
import 'package:diconnection/src/presentation/widget/diconnect_stats_modal.dart';
import 'package:sizer/sizer.dart';

class ConsumerDetailDisconnected extends StatefulWidget {
  final int index;
  final ConsumerModel consumerData;
  final Function onPressedFunction;
  const ConsumerDetailDisconnected(
      {Key? key,
      required this.consumerData,
      required this.onPressedFunction,
      required this.index})
      : super(key: key);

  @override
  State<ConsumerDetailDisconnected> createState() => _ConsumerDetailDisconnectedState();
}

class _ConsumerDetailDisconnectedState extends State<ConsumerDetailDisconnected> {
  double fontDefault = 16.0;
  @override
  Widget build(BuildContext context) {
    ConsumerModel consumerData = widget.consumerData;
    bool stats = consumerData.isConnected ?? false;
    return Scaffold(
      appBar: AppBar(
         backgroundColor: kScaffoldColor,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _menuItem("Account Number:", consumerData.accountNo ?? "", fontVal: fontDefault),
              _menuItem("Consumer Name:", consumerData.consumerName ?? "", fontVal: fontDefault),
              Padding(
                padding: EdgeInsets.only(left: 8.0.w),
                child: Row(
                  children: [
                    _menuItem("Address:", consumerData.address!, fontVal: 10.0),
                    IconButton(onPressed: (){
                      showDialog(context: context, builder: (context) => const ConsumerLocation());
                    }, icon: const Icon(FontAwesomeIcons.circleInfo))
                  ],
                ),
              ),
              _menuItem("No. of Months:", consumerData.noOfMonths.toString(), fontVal: fontDefault),
              _menuItem("Meter Number:", consumerData.meterNo.toString(), fontVal: fontDefault),
              _menuItem("previous Reading:", consumerData.lastReading.toString(), fontVal: fontDefault),
              _menuItem("Unpaid Balance:", "P${consumerData.billAmount.toString()}", fontVal: fontDefault),
              Padding(
                padding: EdgeInsets.only(left: stats ? 0 : 12.0.w),
                child: Row(
                  children: [
                    _menuItem("Status", stats ? "ACTIVE" : "DISCONNECTED", colorVal: stats ? Colors.green : Colors.red, fontVal: stats ? 22.0 : 16.0),
                    stats ? Container() :IconButton(onPressed: (){
                      final discon = DisconnectModel(
                      dateTimeDisconnect: consumerData.disconnectedDate!,
                      teamAssigned: consumerData.disconnectionTeam!.teamName ?? ""
                      );
                      showDialog(context: context, builder: (context) => DisconnectStatusModal(disconnectStats: discon,));
                    }, icon: const Icon(FontAwesomeIcons.circleInfo))
                  ],
                ),
              ),
              _menuItem("Current Reading:", consumerData.currentReading.toString(), fontVal: fontDefault),
              _menuItem("Remarks:", consumerData.remarks ?? "", fontVal: fontDefault),
            ],
          ),
        ],
      ),
    );
  }

  String _team(int val){
    switch(val){
      case 0: return "N/A";
      case 1: return "TEAM 1";
      case 2: return "TEAM 2";
      case 3: return "TEAM 3";
      case 4: return "TEAM 4";
      case 5: return "TEAM 5";
      default: return "N/A";
    }
    
  }

  Widget _menuItem(String label, String value, {double fontVal = 10, Color colorVal = Colors.red}){
    return SizedBox(
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 12.0.sp),),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontVal.sp, color: colorVal),),
        ],
      ),
    );
  }
}