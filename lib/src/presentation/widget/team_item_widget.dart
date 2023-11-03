import 'package:flutter/material.dart';
import 'package:putulinmo/src/core/messages/reminder_message/reminder_message.dart';

class TeamItemWidget extends StatefulWidget {
  final String teamName;
  final IconData icondata;
  final Function onPressedFunction;
  const TeamItemWidget(
      {Key? key,
      required this.teamName,
      required this.icondata,
      required this.onPressedFunction})
      : super(key: key);

  @override
  State<TeamItemWidget> createState() => _TeamItemWidgetState();
}

class _TeamItemWidgetState extends State<TeamItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => ReminderMessage(
                    title: 'DISTRIBUTE TEAM',
                    content: 'Assign it to ${widget.teamName}?',
                    textButtons: [
                      TextButton(onPressed: () {}, child: const Text('Yes')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'))
                    ]));
      },
      child: Card(
        elevation: 12.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 18.0),
          child: Column(
            children: [Icon(widget.icondata), Text(widget.teamName)],
          ),
        ),
      ),
    );
  }
}
