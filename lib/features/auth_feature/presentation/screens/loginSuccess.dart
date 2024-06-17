import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/reset_password.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/custom_button.dart';

class LoginSuccess extends StatefulWidget {
  const LoginSuccess({super.key});

  @override
  State<LoginSuccess> createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80, left: 35, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/true.png"),
              SizedBox(height: 30,),
              TextWidget(title: "Phone Number Verified",titleSize: 25,titleColor: Colors.black,titleFontWeight: FontWeight.bold,),
              SizedBox(height: 50,),
              TextWidget(title: "Congratulations, your phone number ",titleSize: 17,titleColor: Colors.grey,),
              TextWidget(title: "has been verified. You can start using",titleSize: 17,titleColor: Colors.grey,),
              TextWidget(title: "the app",titleSize: 17,titleColor: Colors.grey,),
              SizedBox(height:  180,),
              CustomButton(
                text: "Continue",
                color: Colors.blue,
                onPressed: (context) {
                  // Execute validation logic here

                   Navigator.push(context,  MaterialPageRoute(builder: (context) => ResetPassword()));

                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
