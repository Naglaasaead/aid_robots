import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/custom_alert_dialog.dart';

class CancelAlert extends StatefulWidget {
  const CancelAlert({Key? key}) : super(key: key);

  @override
  State<CancelAlert> createState() => _CancelAlertState();
}

class _CancelAlertState extends State<CancelAlert> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showAlertDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(),
      ),
    );
  }

  void showAlertDialog() {
    globalAlertDialogue(
      "Do You want to cancel Appointment",
      title2: "Appointment with Dr. Jennie Thorn will be cancelled",
      onCancel: () {
        print("Failed");
        Navigator.of(context).pop();
        //   "CANCELLED FAILED"
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Center(
                child: TextWidget(
                  title: 'CANCELLED FAILED',
                  titleColor: Colors.red,
                  titleFontWeight: FontWeight.bold,
                  titleSize: 30,
                ),
              ),
            );
          },
        );
      },
      onOk: () {
        print("Success");
        Navigator.of(context).pop();
        //   "CANCELLED FAILED"
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Center(
                child: TextWidget(
                  title: 'SUCCESS DONE',
                  titleColor: Colors.blueAccent,
                  titleFontWeight: FontWeight.bold,
                  titleSize: 30,
                ),
              ),
            );
          },
        );
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Appointment()));
      },
      okButtonText: "Confirm",
      cancelButtonText: "Reject",
      iconData: Icons.warning,
      iconDataColor: Colors.red,
      iconBackColor: Colors.grey,
      canCancel: true,
    );
  }

}
