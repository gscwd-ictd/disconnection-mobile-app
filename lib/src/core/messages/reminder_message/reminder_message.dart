import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReminderMessage extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> textButtons;

  const ReminderMessage({Key? key, required this.title, required this.content, required this.textButtons}) : super(key: key);

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
                "assets/images/reminder.png",
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
      actions: textButtons
    );
  }
}

