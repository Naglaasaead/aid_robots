
import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/widgets/custom_button.dart';
import '../../../../app/widgets/custom_text_feildEmail.dart';
import 'otp.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late RegExp passwordRegExp;
  // Create GlobalKey for the Form
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Set the Form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/forget_pass.png"),
                SizedBox(height: 30,),
                TextWidget(title: "Forgot Password?", titleSize: 30, titleColor: Colors.black, titleFontWeight: FontWeight.bold,),
                SizedBox(height: 25,),
                TextWidget(title: "Don’t worry! it happens. Please enter the ", titleSize: 16, titleColor: Colors.black,),
                TextWidget(title: "address associated with your account.", titleSize: 16, titleColor: Colors.black,),
                SizedBox(height: 20,),
                CustomTextField(
                  onChanged: (value) {

                  },
                  obscureText: false,
                  text: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]+'))],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  }, controller: passwordController,
                ),
                SizedBox(height: 40,),
                CustomButton(
                  text: "Submit",

                  color: Colors.blue,
                  onPressed: (p0) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Otp()));
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

