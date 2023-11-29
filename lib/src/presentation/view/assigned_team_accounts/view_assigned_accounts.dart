import 'package:diconnection/src/presentation/view/assigned_team_accounts/disconnected_screen.dart/disconnected_screen.dart';
import 'package:diconnection/src/presentation/view/assigned_team_accounts/for_disconnect_screen.dart/for_disconnect_screen.dart';
import 'package:flutter/material.dart';
import 'package:diconnection/src/core/handler/checkBoxHandler/checkBoxHandler.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/models/consumer_model/consumer_model.dart';
import 'package:sizer/sizer.dart';

class AssignedAccounts extends StatefulWidget {
  final String address;
  final List<ConsumerModel> consumerList;
  const AssignedAccounts(
      {Key? key, required this.consumerList, required this.address})
      : super(key: key);

  @override
  State<AssignedAccounts> createState() => _AssignedAccountsState();
}

class _AssignedAccountsState extends State<AssignedAccounts> {
  TextEditingController txtSearch = TextEditingController();
  final PageController pageController = PageController();
  bool isSecondPage = false;

  @override
  void initState() {
    // TODO: implement initState
    isSecondPage = false;
    pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ConsumerModel> consumerList = widget.consumerList;
    var forDiscon = consumerList
        .where((c) =>
            c.isConnected == true &&
            c.consumerName!.toUpperCase().contains(txtSearch.text.toUpperCase()))
        .toList();
    var disconnected = consumerList
        .where((c) =>
            c.isConnected == false &&
            c.consumerName!.toUpperCase().contains(txtSearch.text.toUpperCase()))
        .toList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
        title: Text(widget.address),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 10.0),
            child: Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 70.0.w,
                  child: TextField(
                    onChanged: (val) {
                      CheckBoxHandler.distributeSelected = [];
                      setState(() {});
                    },
                    controller: txtSearch,
                    style: TextStyle(fontSize: 12.0.sp, color: kWhiteColor),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            borderSide: BorderSide(
                                color: Colors.black, style: BorderStyle.solid)),
                        hintText: "Search here",
                        hintStyle:
                            TextStyle(fontSize: 12.0.sp, color: kWhiteColor),
                        fillColor: kBackgroundColor,
                        filled: true),
                    enabled: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 70.h,
            child: PageView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                ForDisconnectScreen(consumerList: forDiscon),
                DisconnectedScreen(consumerList: disconnected)
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                    if (pageController.page != 0) {
                      isSecondPage = !isSecondPage;
                    }
                    setState(() {});
                  },
                  child: SizedBox(
                      width: 49.w,
                      height: 8.h,
                      child: Card(
                          color: !isSecondPage ? kLightBlue : primaryMat,
                          child: Center(
                              child: Text("For Disconnect",
                                  style: TextStyle(
                                      color: isSecondPage
                                          ? Colors.black
                                          : Colors.white)))))),
              GestureDetector(
                  onTap: () {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                    if (pageController.page != 1) {
                      isSecondPage = !isSecondPage;
                    }
                    setState(() {});
                  },
                  child: SizedBox(
                      width: 49.w,
                      height: 8.h,
                      child: Card(
                          color: isSecondPage ? kLightBlue : primaryMat,
                          child: Center(
                              child: Text("Disconnected",
                                  style: TextStyle(
                                      color: !isSecondPage
                                          ? Colors.black
                                          : Colors.white))))))
            ],
          )
        ],
      ),
    );
  }
}
