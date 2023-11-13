import 'package:diconnection/src/presentation/widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diconnection/src/core/messages/reminder_message/reminder_message.dart';
import 'package:diconnection/src/core/messages/success_message/success_message.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model.dart';
import 'package:sizer/sizer.dart';

class ConsumerDetailForDisconnect extends StatefulWidget {
  final int index;
  final ConsumerModel consumerData;
  final Function onPressedFunction;
  const ConsumerDetailForDisconnect(
      {Key? key,
      required this.consumerData,
      required this.onPressedFunction,
      required this.index})
      : super(key: key);

  @override
  State<ConsumerDetailForDisconnect> createState() => _ConsumerDetailForDisconnectState();
}

class _ConsumerDetailForDisconnectState extends State<ConsumerDetailForDisconnect> {
  TextEditingController txtCurrentReader = TextEditingController();
  TextEditingController txtRemarks = TextEditingController();
  bool isFormValidate = false;
  @override
  Widget build(BuildContext context) {
    ConsumerModel consumerData = widget.consumerData;
    bool stats = consumerData.status;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: 0, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            SizedBox(
              height: 80.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      Text(
                        "Address:",
                        style: TextStyle(fontSize: 12.0.sp),
                      ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Text(
                          "Proof:",
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                      ),
                      SizedBox(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              "Remarks:",
                              style: TextStyle(fontSize: 12.0.sp),
                            ),
                          )),
                      SizedBox(
                          height: !stats ? null : 50,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              "Current Reading:",
                              style: TextStyle(fontSize: 12.0.sp),
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          consumerData.accountNumber,
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          consumerData.name!,
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          consumerData.address!,
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          consumerData.numMonths.toString(),
                          style: TextStyle(
                              fontSize: 12.0.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          consumerData.meterNumber.toString(),
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          consumerData.prevReading.toString(),
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "P${consumerData.unpaidBal}",
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          stats ? "ACTIVE" : "DISCONNECTED",
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                        ),
                        const ImagePickerWidget(),
                        SizedBox(
                          height: 100.0,
                          width: 50.0.w,
                          child: !stats ? Text(consumerData.remarks) : TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            controller: txtRemarks,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                    borderSide: BorderSide(
                                        color: Colors.black,
                                        style: BorderStyle.solid)),
                                hintText: "Input Remarks Here",
                                hintStyle: TextStyle(
                                    fontSize: 12.0.sp, color: kWhiteColor),
                                fillColor: kBackgroundColor,
                                filled: true),
                            enabled: true,
                          ),
                        ),
                        SizedBox(
                          height: !stats ? null : 50,
                          width: 50.0.w,
                          child: !stats ? Text(consumerData.currentReading.toString()) : TextField(
                            keyboardType: const TextInputType.numberWithOptions(
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                    borderSide: BorderSide(
                                        color: Colors.black,
                                        style: BorderStyle.solid)),
                                hintText: "Input Reading Here",
                                hintStyle: TextStyle(
                                    fontSize: 12.0.sp, color: kWhiteColor),
                                fillColor: kBackgroundColor,
                                filled: true),
                            enabled: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            !stats ? Container() : Center(
                child: GestureDetector(
              onTap: !isFormValidate
                  ? () {}
                  : () {
                      widget.onPressedFunction();
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => ReminderMessage(
                                  title: 'DISCONNECT ACCOUNT?',
                                  content:
                                      'Confirm Disconnection for ${consumerData.name}?',
                                  textButtons: [
                                    TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) =>
                                                  SuccessMessage(
                                                    title: "Success",
                                                    content:
                                                        "Disconnect Successfully",
                                                    onPressedFunction: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                  ));
                                        },
                                        child: const Text('Yes')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No'))
                                  ]));
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
                        "DISCONNECT",
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _checkValidation() {
    setState(() {
      if (txtRemarks.text.isNotEmpty && txtCurrentReader.text.isNotEmpty) {
        isFormValidate = true;
      } else {
        isFormValidate = false;
      }
    });
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
