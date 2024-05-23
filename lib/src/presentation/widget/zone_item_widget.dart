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
        // widget.onPressedFunction();
        // String address =
        //     "${zoneData.barangay} Z${zoneData.zoneNumber} Book${zoneData.bookNumber}";
        String address = zoneData.barangay;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AssignedAccounts(
                  consumerList: zoneData.consumerList,
                  address: address,
                  index: widget.index,
                )));
      },
      child: Card(
        color: isDisconnected ? Colors.greenAccent : null,
        elevation: 12.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 4.0, right: 8.0, top: 8.0, bottom: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Text(zoneData.totalCount.toString()),
                ),
                // leading: SizedBox(
                //   child: Text(
                //     zoneData.totalCount.toString(),
                //   ),
                // ),
                title: Text(barangay),
                subtitle: Row(
                  children: [
                    Text("Zones : ${zoneData.zoneNumber}"),
                    SizedBox(
                      width: 2.w,
                    ),
                    // const Spacer(flex: ),
                    Text("Book : ${zoneData.bookNumber}")
                  ],
                ),
                trailing: const Icon(Icons.view_headline),
              )
            ],
          ),
        ),
      ),
    );
  }
}
