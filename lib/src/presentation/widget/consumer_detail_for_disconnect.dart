import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diconnection/src/core/enums/status/status_enum.dart';
import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/core/messages/error_message/error_message.dart';
import 'package:diconnection/src/core/messages/verifying_messgae/verifying_message.dart';
import 'package:diconnection/src/core/messages/warning_message/warning_message.dart';
import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:diconnection/src/data/services/auth_provider/auth_provider.dart';
import 'package:diconnection/src/data/services/disconnection_provider/disconnection_provider.dart';
import 'package:diconnection/src/data/services/sync_provider/sync_provider.dart';
import 'package:diconnection/src/presentation/widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diconnection/src/core/messages/reminder_message/reminder_message.dart';
import 'package:diconnection/src/core/messages/success_message/success_message.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sizer/sizer.dart';

class ConsumerDetailForDisconnect extends ConsumerStatefulWidget {
  final int index;
  final bool last;
  final ConsumerModel consumerData;
  final Function onPressedFunction;
  const ConsumerDetailForDisconnect(
      {super.key,
      required this.consumerData,
      required this.onPressedFunction,
      required this.index,
      required this.last});

  @override
  ConsumerState<ConsumerDetailForDisconnect> createState() =>
      _ConsumerDetailForDisconnectState();
}

class _ConsumerDetailForDisconnectState
    extends ConsumerState<ConsumerDetailForDisconnect> {
  TextEditingController txtCurrentReader = TextEditingController();
  TextEditingController txtCustomRemarks = TextEditingController();
  TextEditingController txtSealNo = TextEditingController();
  final MultiSelectController<dynamic> controller = MultiSelectController();
  final MultiSelectController<dynamic> itemController = MultiSelectController();
  String selectRemark = "";
  bool isFormValidate = false,
      isRead = true,
      isDisconnected = true,
      isCustom = false;
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
    bool stats = !(consumerData.status == StatusEnum.mlDone.getIntVal ||
        consumerData.status == StatusEnum.done.getIntVal);
    bool isMainLine = consumerData.status == StatusEnum.mlOngoing.getIntVal;
    double a = double.parse(consumerData.billAmount!);
    controller.setOptions(UtilsHandler.remarks);
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
        // padding: EdgeInsets.only(
        //     top: 0, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Separate Account Number UI
            ListTile(
              leading: Icon(
                Icons.account_circle_sharp,
                size: 35,
                color: Colors.blue[600],
              ),
              title: Text(consumerData.consumerName ?? ""),
              subtitle: Text(consumerData.accountNo ?? ""),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 2.0),
            //   child: SizedBox(
            //     height: 4.h,
            //     child: Row(
            //       children: [
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Text(
            //               "Account Number:",
            //               style: TextStyle(fontSize: 12.0.sp),
            //             ),
            //           ],
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 8.0),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 consumerData.accountNo ?? "",
            //                 style: TextStyle(
            //                     fontSize: 12.0.sp, fontWeight: FontWeight.bold),
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            //Separate Account Number Consumer Name
            Divider(
              thickness: 1,
              endIndent: 10,
              indent: 10,
              color: Colors.blue[50],
            ),
            ListTile(
              leading: Icon(
                Icons.location_on_sharp,
                size: 35,
                color: Colors.blue[600],
              ),
              title: Text(consumerData.address ?? ""),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0),
            //   child: FittedBox(
            //     child: Row(
            //       children: [
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Text(
            //               "Consumer Name:",
            //               style: TextStyle(fontSize: 12.0.sp),
            //             ),
            //           ],
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 8.0),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               SizedBox(
            //                 width: 60.w,
            //                 child: Text(
            //                   consumerData.consumerName ?? "",
            //                   // softWrap: true,
            //                   style: TextStyle(
            //                       fontSize: 12.0.sp,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 20.0.w),
            //   child: SizedBox(
            //     height: txtSize.width > 150 ? 6.h : null,
            //     child: Row(
            //       children: [
            //         Text(
            //           "Address:",
            //           style: TextStyle(fontSize: 12.0.sp),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 8.0),
            //           child: SizedBox(
            //               width: 60.w,
            //               child: Text(
            //                 consumerData.address!,
            //                 softWrap: true,
            //                 maxLines: 3,
            //                 style: textStyle,
            //               )),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            Divider(
              thickness: 1,
              endIndent: 10,
              indent: 10,
              color: Colors.blue[50],
            ),
            ListTile(
              leading: Icon(
                Icons.electric_meter_rounded,
                size: 35,
                color: Colors.blue[600],
              ),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Meter No.", style: TextStyle(fontSize: 14)),
                  Text("Previous Reading", style: TextStyle(fontSize: 14))
                ],
              ),
              // Text(consumerData.meterNo ?? ""),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    consumerData.meterNo ?? "",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    consumerData.lastReading.toString(),
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
              endIndent: 10,
              indent: 10,
              color: Colors.blue[50],
            ),
            ListTile(
              leading: Icon(Icons.info_outline_rounded,
                  size: 35, color: Colors.red[500]),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("No. of Months", style: TextStyle(fontSize: 14)),
                  Text("Balance", style: TextStyle(fontSize: 14))
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(consumerData.noOfMonths.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(
                    "P ${a.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
              endIndent: 10,
              indent: 10,
              color: Colors.blue[50],
            ),
            ListTile(
              title: const Text("Current Reading"),
              subtitle: TextField(
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ], // Only numbers can be entered
                controller: txtCurrentReader,
                scrollPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).viewInsets.bottom + 5),
                onChanged: (val) {
                  _checkValidation();
                },
                style: TextStyle(fontSize: 12.0.sp, color: kWhiteColor),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid)),
                    hintText: isRead ? "Input Current Here" : "Not Available",
                    hintStyle: TextStyle(fontSize: 12.0.sp),
                    fillColor: isRead ? Colors.white : Colors.grey,
                    filled: true),
                enabled: isRead,
              ),
              trailing: Checkbox(
                  value: !isRead,
                  onChanged: (val) {
                    isRead = !isRead;
                    txtCurrentReader.text = "";
                    _checkValidation();
                  }),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0),
            //   child: SizedBox(
            //     height: 20.h,
            //     child: Row(
            //       children: [
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Text(
            //               "No. of Months:",
            //               style: TextStyle(fontSize: 12.0.sp),
            //             ),
            //             Text(
            //               "Meter Number:",
            //               style: TextStyle(fontSize: 12.0.sp),
            //             ),
            //             Text(
            //               "Previous Reading:",
            //               style: TextStyle(fontSize: 12.0.sp),
            //             ),
            //             Text(
            //               "Unpaid Balance:",
            //               style: TextStyle(fontSize: 12.0.sp),
            //             ),
            //             Text(
            //               "Status:",
            //               style: TextStyle(fontSize: 12.0.sp),
            //             ),
            //           ],
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 8.0),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 consumerData.noOfMonths.toString(),
            //                 style: TextStyle(
            //                     fontSize: 12.0.sp,
            //                     color: Colors.red,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //               Text(
            //                 consumerData.meterNo.toString(),
            //                 style: TextStyle(
            //                     fontSize: 12.0.sp, fontWeight: FontWeight.bold),
            //               ),
            //               Text(
            //                 consumerData.lastReading.toString(),
            //                 style: TextStyle(
            //                     fontSize: 12.0.sp, fontWeight: FontWeight.bold),
            //               ),
            //               Text(
            //                 "P${a.toStringAsFixed(2)}",
            //                 style: TextStyle(
            //                     fontSize: 12.0.sp, fontWeight: FontWeight.bold),
            //               ),
            //               Text(
            //                 // stats ? "ACTIVE" : "DISCONNECTED",
            //                 getStatus(consumerData.status!).getStringVal,
            //                 style: TextStyle(
            //                     fontSize: 12.0.sp,
            //                     fontWeight: FontWeight.bold,
            //                     color: getStatus(consumerData.status!) ==
            //                             StatusEnum.cancelled
            //                         ? Colors.red
            //                         : null),
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            //Separate checkbox for cant disconnect
            ListTile(
              title: const Text("Serial Number"),
              subtitle: TextField(
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ], // Only numbers can be entered
                controller: txtSealNo,
                scrollPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).viewInsets.bottom + 5),
                onChanged: (val) {
                  _checkValidation();
                },
                style: TextStyle(fontSize: 12.0.sp, color: kWhiteColor),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid)),
                    hintText: "Input Serial Number Here",
                    hintStyle: TextStyle(fontSize: 12.0.sp),
                    fillColor: isDisconnected ? Colors.white : Colors.grey,
                    filled: true),
                enabled: isRead,
              ),
              trailing: Checkbox(
                  value: !isDisconnected,
                  onChanged: (val) {
                    isDisconnected = !isDisconnected;
                    _checkValidation();
                  }),
            ),
            ListTile(
              title: const Text("Remarks"),
              subtitle: MultiSelectDropDown<dynamic>(
                controller: controller,
                maxItems: 3,
                onOptionSelected: (List<ValueItem> selectedOptions) {
                  if (selectedOptions.isNotEmpty) {
                    selectRemark = selectedOptions[0].label;
                  } else {
                    selectRemark = "";
                  }
                  _checkValidation();
                },
                options: UtilsHandler.remarks,
                selectionType: SelectionType.single,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 200,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),
            ),
            ListTile(
              title: const Text("Proof"),
              subtitle: _imageWidget,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              onPressed: () => {},
              child: const Text("Submit"),
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
                                        title: "Already Paid",
                                        content:
                                            "Please abort disconnection the Consumer was already paid",
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
      String finalRemarks = selectRemark + txtCustomRemarks.text;
      if (finalRemarks.isNotEmpty &&
          txtSealNo.text.isNotEmpty &&
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
    int stats = a.jobCode == 33
        ? StatusEnum.mlDone.getIntVal
        : StatusEnum.done.getIntVal;
    stats = isDisconnected ? stats : StatusEnum.cancelled.getIntVal;
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
        remarks: '${txtSealNo.text} $selectRemark ${txtCustomRemarks.text}',
        disconnectionDate: a.disconnectionDate,
        disconnectedDate: isDisconnected ? a.disconnectedDate : null,
        zoneNo: a.zoneNo,
        bookNo: a.bookNo,
        isConnected: !isDisconnected,
        isPayed: a.isPayed,
        disconnectionTeam: a.disconnectionTeam,
        status: stats,
        proofOfDisconnection: a.proofOfDisconnection,
        seqNo: a.seqNo,
        disconnectedTime: a.disconnectedTime,
        jobCode: a.jobCode);
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
