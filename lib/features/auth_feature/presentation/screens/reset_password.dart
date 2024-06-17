
import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/custom_button.dart';
import '../../../../app/widgets/custom_text_feildEmail.dart';
import 'login.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late RegExp passwordRegExp;
  // Create GlobalKey for the Form
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80,left: 35,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/Secure login.png"),
              SizedBox(height: 30,),
              TextWidget(title: "Reset Password?",titleFontWeight: FontWeight.bold,titleSize: 25,titleColor: Colors.black,),
              SizedBox(height: 30,),
              CustomTextField(

                obscureText: true,
                onChanged: (value) {


                },
                text: ' Password',
                controller: passwordController,
                suffixIcon: Icon(Icons.remove_red_eye),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                }, inputFormatters: [],
              ),
              SizedBox(height: 15),
              CustomTextField(
                onChanged: (value) {

                },
                text: 'Confirm Password',
                 obscureText: true,
                suffixIcon: Icon(Icons.remove_red_eye),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                }, inputFormatters: [],
                controller: passwordController,
              ),
              SizedBox(height: 70,),
              CustomButton(
                text: "Change Password",
                color: Colors.blue,
                onPressed: (context) {
                  // Execute validation logic here

                    Navigator.push(context,  MaterialPageRoute(builder: (context) => LoginScreens()));

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
