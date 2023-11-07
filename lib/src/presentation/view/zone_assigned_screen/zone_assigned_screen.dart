import 'package:diconnection/src/core/enums/auth/auth_level.dart';
import 'package:diconnection/src/core/handler/checkBoxHandler/checkBoxHandler.dart';
import 'package:diconnection/src/core/utils/constants.dart';
import 'package:diconnection/src/data/mock/zones_mock.dart';
import 'package:diconnection/src/data/models/zone_model.dart';
import 'package:diconnection/src/presentation/widget/Zone_item_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ZoneAssignedScreen extends StatefulWidget {
  const ZoneAssignedScreen({super.key});

  @override
  State<ZoneAssignedScreen> createState() => _ZoneAssignedScreenState();
}

class _ZoneAssignedScreenState extends State<ZoneAssignedScreen> {
  TextEditingController txtSearch = TextEditingController();
  List<ZoneModel> zonesData = ZonesMock.zoneList;
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
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
                      setState(() {
                        // _alterfilter(val);
                      });
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
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SizedBox(
              height: 77.h,
              width: 100.w,
              child: Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: SizedBox(
                    height: 77.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: txtSearch.text == ""
                          ? zonesData.length
                          : zonesData.length,
                      itemBuilder: (context, index) {
                        CheckBoxHandler.distributeSelected.add(false);
                        return ZoneItemWidget(
                          zoneData: txtSearch.text == ""
                              ? zonesData[index]
                              : zonesData[index],
                          index: index,
                          onPressedFunction: () {},
                          isDiconnected: true
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}