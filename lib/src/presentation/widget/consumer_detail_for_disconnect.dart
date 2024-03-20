import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diconnection/src/core/enums/status/status_enum.dart';
import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/core/messages/error_message/error_message.dart';
import 'package:diconnection/src/core/messages/verifying_messgae/verifying_message.dart';
import 'package:diconnection/src/core/messages/warning_message/warning_message.dart';
import 'package:diconnection/src/core/shared_preferences/delete_preferences.dart';
import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:diconnection/src/data/services/auth_provider/auth_provider.dart';
import 'package:diconnection/src/data/services/disconnection_provider/disconnection_provider.dart';
import 'package:diconnection/src/presentation/widget/error_validation_widget.dart';
import 'package:diconnection/src/presentation/widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diconnection/src/core/messages/reminder_message/reminder_message.dart';
import 'package:diconnection/src/core/messages/success_message/success_message.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class ConsumerDetailForDisconnect extends ConsumerStatefulWidget {
  final int index;
  final ConsumerModel consumerData;
  final Function onPressedFunction;
  const ConsumerDetailForDisconnect(
      {super.key,
      required this.consumerData,
      required this.onPressedFunction,
      required this.index});

  @override
  ConsumerState<ConsumerDetailForDisconnect> createState() =>
      _ConsumerDetailForDisconnectState();
}

class _ConsumerDetailForDisconnectState
    extends ConsumerState<ConsumerDetailForDisconnect> {
  TextEditingController txtCurrentReader = TextEditingController();
  TextEditingController txtRemarks = TextEditingController();
  bool isFormValidate = false, isRead = true, isDisconnected = true;
  late StreamController<int> _events;
  late Widget _imageWidget;

  @override
  void initState() {
    UtilsHandler.mediaFileList = [];
    _imageWidget = ImagePickerWidget(onChanged: () {
      _checkValidation();
    });
    _events = StreamController<int>();
    super.initState();
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 3,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    ConsumerModel consumerData = widget.consumerData;
    bool stats = consumerData.isConnected ?? false;
    final disconnection = ref.watch(asyncDisconnectionProvider);
    final TextStyle textStyle =
        TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold);
    final Size txtSize = _textSize(consumerData.address!, textStyle);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: 0, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Separate Account Number Consumer Name
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 10.h,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Account Number:",
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                        Text(
                          "Consumer Name:",
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            consumerData.accountNo ?? "",
                            style: TextStyle(
                                fontSize: 10.0.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 60.w,
                            child: Text(
                              consumerData.consumerName ?? "",
                              // softWrap: true,
                              style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0.w),
              child: SizedBox(
                height: txtSize.width > 150 ? 6.h : null,
                child: Row(
                  children: [
                    Text(
                      "Address:",
                      style: TextStyle(fontSize: 12.0.sp),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                          width: 60.w,
                          child: Text(
                            consumerData.address!,
                            softWrap: true,
                            maxLines: 3,
                            style: textStyle,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 20.h,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "No. of Months:",
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                        Text(
                          "Meter Number:",
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                        Text(
                          "Previous Reading:",
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                        Text(
                          "Unpaid Balance:",
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                        Text(
                          "Status:",
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            consumerData.noOfMonths.toString(),
                            style: TextStyle(
                                fontSize: 12.0.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            consumerData.meterNo.toString(),
                            style: TextStyle(
                                fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            consumerData.lastReading.toString(),
                            style: TextStyle(
                                fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "P${consumerData.billAmount}",
                            style: TextStyle(
                                fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            // stats ? "ACTIVE" : "DISCONNECTED",
                            getStatus(consumerData.status!).getStringVal,
                            style: TextStyle(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold,
                                color: getStatus(consumerData.status!) ==
                                        StatusEnum.cancelled
                                    ? Colors.red
                                    : null),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            //Separate checkbox for cant disconnect
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Text(
                    "Can't disconnect?",
                    style: TextStyle(fontSize: 12.0.sp),
                  ),
                  Checkbox(
                      value: !isDisconnected,
                      onChanged: (val) {
                        isDisconnected = !isDisconnected;
                        _checkValidation();
                      })
                ],
              ),
            ),
            //Separate Current Reading
            SizedBox(
              height: 8.h,
              width: 88.w,
              child: Row(
                children: [
                  SizedBox(
                      height: !stats ? null : 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          "Current Reading:",
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      height: !stats ? null : 50,
                      width: 50.0.w,
                      child: !stats
                          ? Text(consumerData.currentReading.toString())
                          : TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true, signed: false),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]')),
                              ], // Only numbers can be entered
                              controller: txtCurrentReader,
                              scrollPadding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).viewInsets.bottom +
                                          5),
                              onChanged: (val) {
                                _checkValidation();
                              },
                              style: TextStyle(
                                  fontSize: 12.0.sp, color: kWhiteColor),
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16.0)),
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          style: BorderStyle.solid)),
                                  hintText: isRead
                                      ? "Input Reading Here"
                                      : "Not Available",
                                  hintStyle: TextStyle(
                                      fontSize: 12.0.sp, color: kWhiteColor),
                                  fillColor:
                                      isRead ? kBackgroundColor : Colors.grey,
                                  filled: true),
                              enabled: isRead,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            //Separate checkbox for cant read meter
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Text(
                    "Can't read meter?",
                    style: TextStyle(fontSize: 12.0.sp),
                  ),
                  Checkbox(
                      value: !isRead,
                      onChanged: (val) {
                        isRead = !isRead;
                        txtCurrentReader.text = "";
                        _checkValidation();
                      }),
                ],
              ),
            ),
            //Separate Remarks UI
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: SizedBox(
                height: 16.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            "Remarks:",
                            style: TextStyle(fontSize: 12.0.sp),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        height: 110.0,
                        width: 50.0.w,
                        child: Column(
                          children: [
                            !stats
                                ? Text(consumerData.remarks ?? "")
                                : TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                    controller: txtRemarks,
                                    scrollPadding: EdgeInsets.symmetric(
                                        vertical: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom +
                                            5),
                                    onChanged: (val) {
                                      _checkValidation();
                                    },
                                    style: TextStyle(
                                        fontSize: 12.0.sp, color: kWhiteColor),
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                style: BorderStyle.solid)),
                                        hintText: "Input Remarks Here",
                                        hintStyle: TextStyle(
                                            fontSize: 12.0.sp,
                                            color: kWhiteColor),
                                        fillColor: kBackgroundColor,
                                        filled: true),
                                    enabled: true,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Separate Image Widget for error handler UI
            Padding(
              padding: EdgeInsets.only(left: 15.0.w),
              child: SizedBox(
                height: 14.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Text(
                        "Proof:",
                        style: TextStyle(fontSize: 12.0.sp),
                      ),
                    ),
                    _imageWidget,
                  ],
                ),
              ),
            ),
            //Separate Submit Button
            !stats
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: GestureDetector(
                      onTap: !isFormValidate
                          ? () {}
                          : () async {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                if (isRead) {
                                  int currentRead =
                                      int.parse(txtCurrentReader.text);
                                  int lastRead = consumerData.lastReading!;
                                  if (currentRead >= lastRead) {
                                    // ignore: use_build_context_synchronously
                                    _disconnectAccount(
                                        context, consumerData, disconnection);
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => WarningMessage(
                                              content:
                                                  'Current reading must be greater than the Previous Reading! $lastRead',
                                              title: 'Current Reading Error',
                                              function: () {
                                                Navigator.pop(context);
                                              },
                                            ));
                                  }
                                } else {
                                  // ignore: use_build_context_synchronously
                                  _disconnectAccount(
                                      context, consumerData, disconnection);
                                }
                              } else {
                                ref
                                    .read(asyncDisconnectionProvider.notifier)
                                    .offlineMode(consumerData);
                                // ignore: use_build_context_synchronously
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => ErrorMessage(
                                          content:
                                              'Please connect to your wifi or mobile data',
                                          onPressedFunction: () {
                                            Navigator.pop(context);
                                          },
                                          title: 'No Internet Connection',
                                        ));
                              }
                            },
                      child: Card(
                        color: isFormValidate ? kWhiteColor : Colors.grey,
                        elevation: 12.0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: SizedBox(
                              width: 40.w,
                              child: Text(
                                "SUBMIT",
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ),
                    )),
                  )
          ],
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

  Future<dynamic> _disconnectAccount(BuildContext context,
      ConsumerModel consumerData, AsyncValue<List<ZoneModel>> disconnection) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ReminderMessage(
                title: 'DISCONNECT ACCOUNT?',
                content:
                    'Confirm Disconnection for ${consumerData.consumerName}?',
                textButtons: [
                  TextButton(
                      onPressed: () {
                        disconnection.when(data: (data) {
                          setState(() {});
                          return true;
                        }, error: (error, stackTrace) {
                          return false;
                        }, loading: () {
                          return true;
                        });
                        _events = StreamController<int>();
                        final input = formUpdate();
                        ref
                            .read(asyncDisconnectionProvider.notifier)
                            .fetchUpdateDisconnection(input, _events);
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => StreamBuilder<int>(
                                initialData: 1,
                                stream: _events.stream,
                                builder: (BuildContext context,
                                    AsyncSnapshot<int> snapshot) {
                                  switch (snapshot.data!) {
                                    case 1:
                                      return VerifyingMessage(
                                        content: 'Uploading:',
                                        onPressedFunction: () {},
                                        state: snapshot.data!,
                                        success: 2,
                                        title: '',
                                      );
                                    case 2:
                                      return VerifyingMessage(
                                        content: 'Submitting',
                                        onPressedFunction: () {},
                                        state: snapshot.data!,
                                        success: 2,
                                        title: '',
                                      );
                                    case 3:
                                      return SuccessMessage(
                                        title: "Success",
                                        content: "Submit Successfully",
                                        onPressedFunction: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context, 'refresh');
                                        },
                                      );
                                    case 400:
                                      return SuccessMessage(
                                        title: "Already Payed",
                                        content:
                                            "Please abort disconnection the Consumer was already payed",
                                        onPressedFunction: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context, 'refresh');
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
                                          ref
                                              .read(asyncAuthProvider.notifier)
                                              .isExpired();
                                        },
                                      );
                                    case 500: //Failed to Verify Please try again
                                      return ErrorMessage(
                                        title: 'Please try again',
                                        content:
                                            'Failed to Verify Please try again',
                                        onPressedFunction: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    case 501: //Failed to upload from API
                                      return ErrorMessage(
                                        title: 'Please try again',
                                        content: 'Failed to upload from API',
                                        onPressedFunction: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    case 502: //Failed to disconnect Consumers from API
                                      return ErrorMessage(
                                        title: 'Please try again',
                                        content:
                                            'Failed to disconnect Consumers from API',
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
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(fontSize: 16.0.sp),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'No',
                        style: TextStyle(fontSize: 16.0.sp),
                      ))
                ]));
  }

  void _checkValidation() {
    setState(() {
      bool cantRead = isRead ? txtCurrentReader.text.isNotEmpty : true;
      if (txtRemarks.text.isNotEmpty &&
          cantRead &&
          UtilsHandler.mediaFileList!.isNotEmpty) {
        isFormValidate = true;
      } else {
        isFormValidate = false;
      }
    });
  }

  ConsumerModel formUpdate() {
    final a = widget.consumerData;
    final b = ConsumerModel(
        disconnectionId: a.disconnectionId,
        accountNo: a.accountNo,
        prevAccountNo: a.prevAccountNo ?? "",
        consumerName: a.consumerName,
        address: a.address,
        meterNo: a.meterNo,
        billAmount: a.billAmount,
        noOfMonths: a.noOfMonths,
        lastReading: a.lastReading,
        currentReading: isRead ? int.parse(txtCurrentReader.text) : null,
        remarks: txtRemarks.text,
        disconnectionDate: a.disconnectionDate,
        disconnectedDate: isDisconnected ? a.disconnectedDate : null,
        zoneNo: a.zoneNo,
        bookNo: a.bookNo,
        isConnected: !isDisconnected,
        isPayed: a.isPayed,
        disconnectionTeam: a.disconnectionTeam,
        status: isDisconnected ? 1 : 2,
        proofOfDisconnection: a.proofOfDisconnection,
        seqNo: a.seqNo,
        disconnectedTime: a.disconnectedTime);
    return b;
  }

  Widget _menuItem(String label, String value,
      {double fontVal = 10, Color colorVal = Colors.red}) {
    return SizedBox(
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.0.sp),
          ),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontVal.sp,
                color: colorVal),
          ),
        ],
      ),
    );
  }
}
