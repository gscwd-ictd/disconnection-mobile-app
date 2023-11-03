import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorMessage extends StatelessWidget {
  final String title;
  final String content;
  final Function onPressedFunction;

  const ErrorMessage({Key? key, required this.title, required this.content, required this.onPressedFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: GoogleFonts.lato(fontWeight: FontWeight.w900),
      ),
      content: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/error.png",
                scale: 2.0,
              ),
              const SizedBox(height: 20.0),
              Text(
                content,
                style: GoogleFonts.lato(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              onPressedFunction();
            },
            child: const Text('Close'))
      ],
    );
  }
}
