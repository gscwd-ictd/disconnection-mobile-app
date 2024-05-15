import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:diconnection/src/data/models/disconnect_model.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DisconnectStatusModal extends StatefulWidget {
  final DisconnectModel disconnectStats;
  const DisconnectStatusModal({Key? key, required this.disconnectStats})
      : super(key: key);

  @override
  State<DisconnectStatusModal> createState() => _DisconnectStatusModalState();
}

class _DisconnectStatusModalState extends State<DisconnectStatusModal> {
  @override
  Widget build(BuildContext context) {
    DisconnectModel disconStats = widget.disconnectStats;
    return AlertDialog(
      content: SizedBox(
        height: 20.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.users),
            Text(disconStats.teamAssigned),
            const Text("Date&Time:"),
            Text(
                '${DateFormat('yyyy-MM-dd').format(disconStats.dateDisconnect)} ${disconStats.timeDisconnect}')
          ],
        ),
      ),
    );
  }
}
