import 'dart:async';

import 'package:diconnection/src/data/services/disconnection_provider/disconnection_provider.dart';
import 'package:diconnection/src/data/services/for_disconnection_provider/for_disconnection_provider.dart';
import 'package:diconnection/src/presentation/widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diconnection/src/core/messages/reminder_message/reminder_message.dart';
import 'package:diconnection/src/core/messages/success_message/success_message.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class ConsumerDetailForDisconnect extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerDetailForDisconnect> createState() =>
      _ConsumerDetailForDisconnectState();
}

class _ConsumerDetailForDisconnectState
    extends ConsumerState<ConsumerDetailForDisconnect> {
  TextEditingController txtCurrentReader = TextEditingController();
  TextEditingController txtRemarks = TextEditingController();
  bool isFormValidate = false;
  late StreamController<bool> _events;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _events = StreamController<bool>();
  }
  @override
  Widget build(BuildContext context) {
    ConsumerModel consumerData = widget.consumerData;
    bool stats = consumerData.isConnected ?? false;
    final disconnection = ref.watch(asyncDisconnectionProvider);
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
                      SizedBox(
                        height: consumerData.address!.length <= 12 ? null : 35,
                        child: Text(
                          "Address:",
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
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
                          consumerData.accountNo ?? "",
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          consumerData.consumerName ?? "",
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            width: 60.w,
                            child: Text(
                              consumerData.address!,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold),
                            )),
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
                          stats ? "ACTIVE" : "DISCONNECTED",
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                        ),
                        const ImagePickerWidget(),
                        SizedBox(
                          height: 100.0,
                          width: 50.0.w,
                          child: !stats
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
                        ),
                        SizedBox(
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
                                      hintText: "Input Reading Here",
                                      hintStyle: TextStyle(
                                          fontSize: 12.0.sp,
                                          color: kWhiteColor),
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
            !stats
                ? Container()
                : Center(
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
                                            'Confirm Disconnection for ${consumerData.consumerName}?',
                                        textButtons: [
                                          TextButton(
                                              onPressed: () {
                                                bool test = false;
                                                test = disconnection.when(
                                                  data: (data){
                                                    setState(() {
                                                    });
                                                    return true;
                                                  }, 
                                                  error: (error, stackTrace){return false;}, 
                                                  loading: (){return true;});
                                                final input = formUpdate();
                                                final result = ref
                                                    .read(
                                                        asyncDisconnectionProvider
                                                            .notifier)
                                                    .fetchUpdateDisconnection(
                                                        input, _events);
                                                
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (context) =>
                                                    StreamBuilder<bool>(
                                                      initialData: true,
                                                      stream: _events.stream, 
                                                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                                                        return snapshot.data!
                                                        ? const Center(
                                                          child: CircularProgressIndicator(),
                                                        )
                                                        : SuccessMessage(
                                                              title: "Success",
                                                              content:
                                                                  "Disconnect Successfully",
                                                              onPressedFunction:
                                                                  () {
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            );
                                                      }));
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
        currentReading: int.parse(txtCurrentReader.text),
        remarks: txtRemarks.text,
        disconnectionDate: a.disconnectionDate,
        disconnectedDate: a.disconnectedDate,
        proofOfDisconnection: a.proofOfDisconnection ?? "",
        zoneNo: a.zoneNo,
        bookNo: a.bookNo,
        isConnected: false,
        isPayed: a.isPayed,
        disconnectionTeam: a.disconnectionTeam);
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
