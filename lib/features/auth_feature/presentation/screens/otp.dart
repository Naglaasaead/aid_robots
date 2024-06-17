import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/custom_button.dart';
import '../../../../app/widgets/otp_widget.dart';
import 'loginSuccess.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  late String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 110, left: 20, right: 20, bottom: 20),
          child: Form(
            child: Column(
              children: [
                Image.asset("assets/images/varification_code.png"),
                SizedBox(height: 30,),
                TextWidget(title: "Verification Code",titleSize: 22,titleColor: Colors.black,titleFontWeight: FontWeight.bold,),
                TextWidget(title: "Confirm with code",titleSize: 16,titleColor: Colors.grey,),
                SizedBox(height: 60,),
                OtpWidget(
                  length: 4,
                  onCompleted: (String value) {
                    otp = value;
                    print("OTP Completed : $otp");
                  },
                  controller: TextEditingController(),
                ),
                SizedBox(height: 20,),
                TextWidget(title: "Resend Code",titleSize: 19,titleColor: Colors.blueAccent,),
                SizedBox(height: 40,),
                CustomButton(

                  text: "Verify",
                  color: Colors.blue,
                  onPressed:(p0) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSuccess()));
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
