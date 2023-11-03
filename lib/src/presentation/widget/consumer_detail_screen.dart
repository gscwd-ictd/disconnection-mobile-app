import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:putulinmo/src/data/models/consumer_model.dart';
import 'package:putulinmo/src/data/models/disconnect_model.dart';
import 'package:putulinmo/src/presentation/widget/consumer_location.dart';
import 'package:putulinmo/src/presentation/widget/diconnect_stats_modal.dart';
import 'package:sizer/sizer.dart';

class ConsumerDetailScreen extends StatefulWidget {
  final int index;
  final ConsumerModel consumerData;
  final Function onPressedFunction;
  const ConsumerDetailScreen(
      {Key? key,
      required this.consumerData,
      required this.onPressedFunction,
      required this.index})
      : super(key: key);

  @override
  State<ConsumerDetailScreen> createState() => _ConsumerDetailScreenState();
}

class _ConsumerDetailScreenState extends State<ConsumerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    ConsumerModel consumerData = widget.consumerData;
    bool stats = consumerData.status;
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _menuItem("Account Number:", consumerData.accountNumber, fontVal: 20.0),
              _menuItem("Consumer Name:", consumerData.name!, fontVal: 20.0),
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
              _menuItem("No. of Months:", consumerData.numMonths.toString(), fontVal: 20.0),
              _menuItem("Mat. Loan Balance:", consumerData.matLoan.toStringAsFixed(2), fontVal: 20.0),
              _menuItem("Meter Number:", consumerData.meterNumber.toString(), fontVal: 20.0),
              _menuItem("previous Reading:", consumerData.prevReading.toString(), fontVal: 20.0),
              _menuItem("Unpaid Balance:", "P${consumerData.unpaidBal.toStringAsFixed(2)}", fontVal: 20.0),
              Padding(
                padding: EdgeInsets.only(left: stats ? 0 : 12.0.w),
                child: Row(
                  children: [
                    _menuItem("Status", stats ? "ACTIVE" : "DISCONNECTED", colorVal: stats ? Colors.green : Colors.red, fontVal: stats ? 22.0 : 16.0),
                    stats ? Container() :IconButton(onPressed: (){
                      final discon = DisconnectModel(
                      dateTimeDisconnect: DateTime.now(),
                      teamAssigned: _team(consumerData.team)
                      );
                      showDialog(context: context, builder: (context) => DisconnectStatusModal(disconnectStats: discon,));
                    }, icon: const Icon(FontAwesomeIcons.circleInfo))
                  ],
                ),
              ),
              _menuItem("Assigned Team:", _team(consumerData.team), fontVal: 20.0),
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