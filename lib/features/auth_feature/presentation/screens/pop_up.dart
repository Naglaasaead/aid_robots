import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/home_patient.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/custom_button.dart';

class PopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(20.0), // تحديد الهوامش الداخلية
      title: Icon(Icons.my_location_sharp, size: 70, color: Colors.blueAccent),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // يجعل العمود يحتل الحد الأدنى من المساحة العمودية
        children: [
          TextWidget(
            title: 'Allow Location',
            titleFontWeight: FontWeight.bold,
            titleSize: 25,
            titleColor: Colors.black,
          ),
          TextWidget(title: 'Grant location access for enhanced features.'),
        ],
      ),
      actions: <Widget>[
        CustomButton(
          text: "Allow Location",
          color: Colors.blue, onPressed: (BuildContext ) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePatient(),));
        },

        ),
      ],
    );
  }
}
