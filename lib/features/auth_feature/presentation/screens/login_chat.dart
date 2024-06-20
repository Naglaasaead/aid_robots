/*
import 'package:aid_robot/features/auth_feature/presentation/screens/reg_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Constant/constant.dart';
import '../../../../app/model/user_model.dart';
import 'Home.dart';

class LoginChat extends StatefulWidget {
  const LoginChat({super.key});

  @override
  State<LoginChat> createState() => _LoginChatState();
}

class _LoginChatState extends State<LoginChat> {
TextEditingController number =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Center(child: Text("Login${current_user}")),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.black87)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Colors.black87)
                ),
                border:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.black87)
                ),
                fillColor: Colors.grey.shade800,
                filled: true
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: () {
                if(users.map((e)=>e.number)==number.text){
                  setState(() {
                    current_user=users[users.indexWhere((_element)=>_element.number==number.text)];
                  });
                }
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));

                */
/*setState(() {
                  current_user=users[users.indexWhere((_element)=>_element.number==number.text)];
                });*//*

              },
              child: Column(
                children: [
                  Container(

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade800),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                    child: Text("loign",style: TextStyle(color: Colors.white),),

                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegsterChat(),));
              },
              child: Column(
                children: [
                  Container(

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade800),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                    child: Text("Register",style: TextStyle(color: Colors.white),),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../app/widgets/myButton.dart';
import 'chat1.dart';

class LoginChat extends StatefulWidget {
  static const String ScreenRoute='sign_screen';
  const LoginChat({super.key});

  @override
  State<LoginChat> createState() => _LoginChatState();
}

class _LoginChatState extends State<LoginChat> {
  final _auth=FirebaseAuth.instance;
  bool   showSpinner=false;
  late String email;
  late String pass;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  height: 180,
                  child:  Image.asset("assets/images/whatsab.png",height: 200,)

              ),
              SizedBox(height: 50,),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value){
                  email=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.orange,width: 1)),
                  focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue,width: 2)),
                ),

              ),
              SizedBox(height: 10,),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value){
                  pass=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Your Password',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.orange,width: 1)),
                  focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue,width: 2)),
                ),

              ),
              SizedBox(height: 10,),
              MyButton(color: Colors.blue[800]!, titel: 'Sign in ', onPress: ()async{
                setState(() {
                  showSpinner=true;
                });
                try{
                  final user=  await _auth.signInWithEmailAndPassword(email: email, password: pass);
                  if(user!=null){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>ChatScreen() ,));
                    setState(() {
                      showSpinner=false;
                    });
                  }
                }catch(e){
                  print(e);
                }
              })

            ],
          ),
        ),
      ),
    );
  }
}
