import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProceedMessage extends StatelessWidget {
  final String title;
  final String content;
  final Function function;

  const ProceedMessage(
      {Key? key,
      required this.title,
      required this.content,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title.toUpperCase(),
        style: GoogleFonts.lato(fontWeight: FontWeight.w900),
      ),
      content: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/warning.png",
                scale: 1.0,
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
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
            onPressed: () {
              function();
            },
            child: const Text('PROCEED'))
      ],
    );
  }
}
