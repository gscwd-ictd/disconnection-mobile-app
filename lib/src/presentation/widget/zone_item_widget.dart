import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:diconnection/src/presentation/view/assigned_team_accounts/view_assigned_accounts.dart';
import 'package:flutter/material.dart';
import 'package:diconnection/src/core/enums/auth/auth_level.dart';
import 'package:diconnection/src/core/handler/checkBoxHandler/checkBoxHandler.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class ZoneItemWidget extends StatefulWidget {
  final int index;
  final ZoneModel zoneData;
  final Function onPressedFunction;
  final bool isDiconnected;
  const ZoneItemWidget(
      {Key? key,
      required this.zoneData,
      required this.onPressedFunction,
      required this.index,
      required this.isDiconnected})
      : super(key: key);

  @override
  State<ZoneItemWidget> createState() => _ZoneItemWidgetState();
}

class _ZoneItemWidgetState extends State<ZoneItemWidget> {
  @override
  Widget build(BuildContext context) {
    ZoneModel zoneData = widget.zoneData;
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
                height: zoneData.barangay.length <= 12 ?40 : 60,
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
                        const Text("Address: "),
                        SizedBox(
                          width: 60.w,
                          child: Text(
                          zoneData.barangay,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 14.sp, 
                            fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Zone: ${zoneData.zoneNumber}"),
                        Text("Book: ${zoneData.bookNumber}"),
                      ],
                    ),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox( width: 40, child: Icon(FontAwesomeIcons.users)),
                            Text(zoneData.totalCount.toString())
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
                  String address = "${zoneData.barangay} Z${zoneData.zoneNumber} Book${zoneData.bookNumber}";
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AssignedAccounts(consumerList: zoneData.consumerList, address: address, index: widget.index,)));
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