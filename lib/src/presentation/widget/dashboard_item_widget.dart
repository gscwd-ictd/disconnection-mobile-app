import 'package:flutter/material.dart';
import 'package:putulinmo/src/core/utils/constants.dart';
import 'package:sizer/sizer.dart';

class DashBoardItemWidget extends StatefulWidget {
  final String title;
  final IconData icondata;
  final Function onPressedFunction;
  const DashBoardItemWidget(
      {Key? key,
      required this.title,
      required this.icondata,
      required this.onPressedFunction})
      : super(key: key);

  @override
  State<DashBoardItemWidget> createState() => _DashBoardItemWidgetState();
}

class _DashBoardItemWidgetState extends State<DashBoardItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressedFunction();
      },
      child: Card(
        elevation: 12.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
          child: Column(
            children: [
              Icon(widget.icondata, color: kLightBlue, size: 32.0),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                  width: 40.w,
                  child: Text(
                    widget.title,
                    softWrap: true,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
