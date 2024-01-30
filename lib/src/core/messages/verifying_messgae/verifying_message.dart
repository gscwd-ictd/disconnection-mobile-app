import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class VerifyingMessage extends StatelessWidget {
  final String title;
  final String content;
  final Function onPressedFunction;
  final int state;
  final int success;

  const VerifyingMessage(
      {super.key,
      required this.title,
      required this.content,
      required this.onPressedFunction,
      required this.state,
      required this.success});

  @override
  Widget build(BuildContext context) {
    TextStyle txtStyle =
        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold);
    return AlertDialog(
      title: Text(
        title,
        style: GoogleFonts.lato(fontWeight: FontWeight.w900),
      ),
      content: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Text(
                'Please Wait',
                style: txtStyle,
              )),
              const SizedBox(height: 20.0),
              Center(
                  child: Text(
                '$content $state/$success',
                style: txtStyle,
              )),
              const SizedBox(height: 20.0),
              const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
