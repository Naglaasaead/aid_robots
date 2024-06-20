/*
import 'package:aid_robot/app/model/user_model.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/login_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Constant/constant.dart';
import 'Home.dart';

class RegsterChat extends StatefulWidget {
  const RegsterChat({super.key});

  @override
  State<RegsterChat> createState() => _RegsterChatState();
}

class _RegsterChatState extends State<RegsterChat> {
  TextEditingController name=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController image=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Center(child: Text("Reg")),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: name,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Name',
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
            TextFormField(
              controller: number,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  hintText: 'Number',
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
            TextFormField(
              controller: image,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'image',
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
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Home()),
                );
                users.add(UserModel(name: name.text, number: number.text, image: image.text, email: '', pass: ''));
                String userNumber = number.text;
               */
/* if (users.contains(userNumber)) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                } else {
                  Get.snackbar('Error', 'User not found');
                }*//*

                if(users.map((e)=>e.number)==number.text){
                  setState(() {
                    current_user=users[users.indexWhere((_element)=>_element.number==number.text)];
                  });

                }
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
            SizedBox(height: 10,),
            InkWell(
               onTap: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginChat(),));
               },
              child: Column(
                children: [
                  Container(

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade800),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                    child: Text("Login",style: TextStyle(color: Colors.white),),

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



import 'package:aid_robot/app/widgets/myButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat1.dart';

class Registration extends StatefulWidget {
  static const String ScreenRoute='register_screen';
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  late String email;
  late String pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onChanged: (value){email=value;},
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
                onChanged: (value){pass=value;},
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
              MyButton(color: Colors.orange[800]!, titel: 'Register', onPress: ()async{
               /* print(email);
                print(pass);*/
              setState(() {
                showSpinner=true;
              });
              try{
                final nuwUser=  await _auth.createUserWithEmailAndPassword(email: email, password: pass);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>ChatScreen() ,));
                setState(() {
                  showSpinner=false;
                });
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
