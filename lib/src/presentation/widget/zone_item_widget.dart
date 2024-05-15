import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:diconnection/src/presentation/view/assigned_team_accounts/view_assigned_accounts.dart';
import 'package:flutter/material.dart';
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
    String barangay = fixText(zoneData.barangay, limit: 40);
    bool notOverSize = (barangay.length <= 22);
    bool isDisconnected = zoneData.consumerList
        .where((element) => element.isConnected == true)
        .isEmpty;
    return GestureDetector(
      onTap: () {
        widget.onPressedFunction();
      },
      child: Card(
        color: isDisconnected ? Colors.greenAccent : null,
        elevation: 12.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 18.0, bottom: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: notOverSize ? 50 : 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text("Address: "),
                        SizedBox(
                          width: 50.w,
                          child: Text(
                            barangay,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 11.sp, fontWeight: FontWeight.bold),
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
                        const SizedBox(
                            width: 40, child: Icon(FontAwesomeIcons.users)),
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
                onTap: () {
                  String address =
                      "${zoneData.barangay} Z${zoneData.zoneNumber} Book${zoneData.bookNumber}";
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AssignedAccounts(
                            consumerList: zoneData.consumerList,
                            address: address,
                            index: widget.index,
                          )));
                },
                child: Container(
                  width: 90.w,
                  height: 3.h,
                  child: Text(
                    "Show more...",
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: isDisconnected ? Colors.black : kLightBlue),
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
}
