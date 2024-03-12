import 'package:cached_network_image/cached_network_image.dart';
import 'package:diconnection/src/core/enums/status/status_enum.dart';
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
  State<ConsumerDetailDisconnected> createState() =>
      _ConsumerDetailDisconnectedState();
}

class _ConsumerDetailDisconnectedState
    extends State<ConsumerDetailDisconnected> {
  double fontDefault = 16.0;
  @override
  Widget build(BuildContext context) {
    ConsumerModel consumerData = widget.consumerData;
    bool stats = consumerData.isConnected ?? false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 98.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _menuItem("Account Number:",
                        value: consumerData.accountNo ?? "",
                        fontVal: fontDefault),
                    _menuItem("Consumer Name:",
                        value: consumerData.consumerName ?? "",
                        fontVal: fontDefault),
                    Padding(
                      padding: EdgeInsets.only(left: 2.0.w),
                      child: Row(
                        children: [
                          _menuItem("Address:",
                              value: consumerData.address!, fontVal: 10.0),
                          // IconButton(
                          //     onPressed: () {
                          //       showDialog(
                          //           context: context,
                          //           builder: (context) =>
                          //               const ConsumerLocation());
                          //     },
                          //     icon: const Icon(FontAwesomeIcons.circleInfo))
                        ],
                      ),
                    ),
                    _menuItem("No. of Months:",
                        value: consumerData.noOfMonths.toString(),
                        fontVal: fontDefault),
                    _menuItem("Meter Number:",
                        value: consumerData.meterNo.toString(),
                        fontVal: fontDefault),
                    _menuItem("previous Reading:",
                        value: consumerData.lastReading.toString(),
                        fontVal: fontDefault),
                    _menuItem("Current Reading:",
                        value: consumerData.currentReading.toString(),
                        fontVal: fontDefault),
                    _menuItem("Unpaid Balance:",
                        value: "P${consumerData.billAmount.toString()}",
                        fontVal: fontDefault),
                    Padding(
                      padding: EdgeInsets.only(left: stats ? 0 : 12.0.w),
                      child: Row(
                        children: [
                          _menuItem("Status",
                              value: stats ? "ACTIVE" : "DISCONNECTED",
                              colorVal: stats ? Colors.green : Colors.red,
                              fontVal: stats ? 22.0 : 16.0),
                          stats
                              ? Container()
                              : IconButton(
                                  onPressed: () {
                                    final discon = DisconnectModel(
                                        dateDisconnect: consumerData
                                            .disconnectedDate!
                                            .toLocal(),
                                        timeDisconnect:
                                            consumerData.disconnectedTime!,
                                        teamAssigned: consumerData
                                                .disconnectionTeam!.teamName ??
                                            "");
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DisconnectStatusModal(
                                              disconnectStats: discon,
                                            ));
                                  },
                                  icon: const Icon(FontAwesomeIcons.circleInfo))
                        ],
                      ),
                    ),
                    _menuItem("Proof Of Disconnection:",
                        value: consumerData.proofOfDisconnection![0].fileName ??
                            "",
                        fontVal: fontDefault,
                        isPhoto: true),
                    _menuItem("Remarks:",
                        value: consumerData.remarks ?? "",
                        fontVal: fontDefault),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _team(int val) {
    switch (val) {
      case 0:
        return "N/A";
      case 1:
        return "TEAM 1";
      case 2:
        return "TEAM 2";
      case 3:
        return "TEAM 3";
      case 4:
        return "TEAM 4";
      case 5:
        return "TEAM 5";
      default:
        return "N/A";
    }
  }

  Widget _menuItem(String label,
      {double fontVal = 10,
      Color colorVal = Colors.red,
      bool isPhoto = false,
      String value = ""}) {
    print(value);
    final String uri = isHttp
        ? 'http://$kHost/disconnection/$value.jpg/profile-photo'
        : 'https://$kHost/disconnection/$value.jpg/profile-photo';
    return SizedBox(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.0.sp),
          ),
          SizedBox(
            width: 55.w,
            child: isPhoto
                ? SizedBox(
                    height: 60,
                    width: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          httpHeaders: {'Authorization': 'Bearer $kToken'},
                          imageUrl: uri,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: InteractiveViewer(
                                          child: CachedNetworkImage(
                                            imageUrl: uri,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        actions: [],
                                      ));
                            },
                            icon: const Icon(FontAwesomeIcons.magnifyingGlass))
                      ],
                    ))
                : Text(
                    value,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontVal.sp,
                        color: colorVal),
                  ),
          )
        ],
      ),
    );
  }
}
