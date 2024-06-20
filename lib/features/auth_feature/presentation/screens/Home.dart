/*
import 'dart:ui';

import 'package:aid_robot/features/auth_feature/presentation/screens/chat1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat2.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Center(child: Text("Home")),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chat1(),));
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(radius: 30,backgroundColor: Colors.blue,),
                      title: Text("Chat 1",style: TextStyle(
                        color: Colors.white,
                        fontWeight:FontWeight.bold
                      ),),
                    ),
                  ),
                  Divider(color: Colors.white,)
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chat2(),));
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(radius: 30,backgroundColor: Colors.orange,),
                      title: Text("Chat 1",style: TextStyle(
                          color: Colors.white,
                          fontWeight:FontWeight.bold
                      ),),
                    ),
                  ),
                  Divider(color: Colors.white,)
                ],
              ),
            )
          ],
        ),

      ),
    );
  }
}
*/


import 'package:aid_robot/features/auth_feature/presentation/screens/reg_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/myButton.dart';
import 'login_chat.dart';

class WelcomeScreen extends StatefulWidget {
  static const String ScreenRoute="welcome_screen";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(

              children: [
                Container(
                  child:Center(child: Image.asset("assets/images/whatsab.png",height: 200,)) ,

                ),
                Text("Message Me",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900,color: Color(0xff2e386b)),)

              ],
            ),
            SizedBox(height: 30,),
            MyButton(color: Colors.yellow[900]!,titel:'Sign in ' ,onPress: (){
              //Navigator.pushNamed(context,  LoginChat.ScreenRoute);
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginChat(),));
            },),
            SizedBox(height: 10,),

            MyButton(color: Colors.blue[800]!,titel:'Register ' ,onPress: (){
             // Navigator.pushNamed(context,  Registration.ScreenRoute);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Registration(),));
            },)
          ],
        ),
      ),
    );
  }
}

