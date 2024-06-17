/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
var emailcontroler =TextEditingController();
var paswordControler=TextEditingController();
var formKey=GlobalKey<FormState>();
bool isPasword=true;
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 150,horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Login",style: TextStyle(
                    fontSize: 25,fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 7,),
                CustomTextFormField(
                  text: "Email Address",
                  prefixIcon: Icon(Icons.email),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Email must be not empty";
                    }
                    return null;
                  },
                  controller: emailcontroler,
                  iconData: Icons.email_outlined,
                  onChange: (value) {
                    print(value);
                  },
                  onSubmit:  (value) {
                    print(value);
                  },),
                SizedBox(height: 10,),
                CustomTextFormField(
                  text: "Password",
                  obscureText: isPasword,
                  suffixIcon:
                  IconButton(onPressed: (){
                    setState(() {
                      isPasword=!isPasword;
                    });
                  }, icon:isPasword? Icon(Icons.visibility_off) : Icon(Icons.visibility),),

                  prefixIcon: Icon(Icons.password),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Password must be not empty";
                    }
                    return null;
                  },
                  controller: paswordControler,
                  iconData: Icons.lock,
                  onChange: (value) {
                    print(value);
                  },
                  onSubmit:  (value) {
                    print(value);
                  },),
                SizedBox(height: 10,),
                CustomButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      print(emailcontroler.text);
                      print(paswordControler.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Test();
                      }));
                    }


                  },
                  background: Colors.blue,
                  width: double.infinity,
                  text: "login",
                  isUpperCase: true,
                ),
                SizedBox(height: 10,),
                CustomButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      print(emailcontroler.text);
                      print(paswordControler.text);

                    }
                  },
                  background: Colors.blue,
                  width: double.infinity,
                  text: "register",
                  isUpperCase: true,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don'\tt have an account?"),
                    SizedBox(width: 4,),
                    Text("Register Now",style: TextStyle(
                        color: Colors.blue
                    )),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


*/
