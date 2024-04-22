import 'package:flutter/material.dart';

class CircularButton extends StatefulWidget {
  final Function? function;
  final Color? buttonColor;
  final String? buttonText;
  final double? buttonHeight;
  final double? buttonWidth;
  final Color? textColor;
  const CircularButton({
    Key? key,
    this.function,
    this.buttonColor,
    this.buttonText,
    this.buttonHeight,
    this.buttonWidth,
    this.textColor,
  }) : super(key: key);

  @override
  _CircularButtonState createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  @override
  Widget build(BuildContext context) {
    // return Visibility(
    //   visible: widget.isVisible,
    //   child: ElevatedButton(
    //     onPressed: () {
    //       widget.function!();
    //     },
    //     child: Text(widget.buttonText!),
    //     style: ElevatedButton.styleFrom(
    //       primary: widget.buttonColor,
    //       padding: EdgeInsets.symmetric(
    //           vertical: widget.buttonPaddingHieght!,
    //           horizontal: widget.buttonPaddingWidth!),
    //       shape:
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    //     ),
    //   ),
    // );
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: widget.buttonHeight,
        width: widget.buttonWidth,
        child: TextButton(
          onPressed: () => widget.function!(),
          style: TextButton.styleFrom(
            backgroundColor: widget.buttonColor,
          ),
          child: Text(
            widget.buttonText!,
            style: TextStyle(color: widget.textColor),
          ),
        ),
      ),
    );
  }
}
