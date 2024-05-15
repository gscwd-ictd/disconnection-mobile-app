import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class ErrorValidationWidget extends StatefulWidget {
  final String validation;
  const ErrorValidationWidget({Key? key, required this.validation})
      : super(key: key);

  @override
  State<ErrorValidationWidget> createState() => _ErrorValidationWidgetState();
}

class _ErrorValidationWidgetState extends State<ErrorValidationWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.exclamation,
            color: Colors.red,
          ),
          const Spacer(),
          Text(widget.validation)
        ],
      ),
    );
  }
}
