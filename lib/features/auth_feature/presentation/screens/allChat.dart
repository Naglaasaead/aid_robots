import 'package:aid_robot/features/auth_feature/presentation/screens/chat1.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/chat4.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/chat5.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_nav_bar.dart';
import 'chat3.dart';

class AllChatUser extends StatefulWidget {
  const AllChatUser({super.key});

  @override
  State<AllChatUser> createState() => _AllChatUserState();
}

class _AllChatUserState extends State<AllChatUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
          backgroundColor: Colors.blue,
          title: Text("AllDoctor".tr(), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
          color: Colors.black),)),
      bottomNavigationBar: const ButtonNavBar(),
      body: SingleChildScrollView(

        child: Container(
          color: Colors.white70,
          child: Column(

            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),));
                },
                child: Container(
                        padding: EdgeInsets.all(10),decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),),width: double.infinity,
                height: 85,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25, // يمكنك تعديل الحجم هنا
                            backgroundImage: AssetImage( "assets/images/n3.jpg",), // ضع مسار الصورة هنا
                          ),
                          SizedBox(width: 7,),
                          Text("Saeed".tr(),style: TextStyle(fontSize: 22,color: Colors.black,),),
                          Spacer(),
                          Text("Online".tr(),style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),

                        ],
                      ),

                    ],
                  ),),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen2(),));
                },
                child: Container(
                  padding: EdgeInsets.all(10),decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),),width: double.infinity,
                  height: 100,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25, // يمكنك تعديل الحجم هنا
                            backgroundImage: AssetImage( "assets/images/d2.png"), // ضع مسار الصورة هنا
                          ),
                          SizedBox(width: 7,),
                          Text("AmrMohamed".tr(),style: TextStyle(fontSize: 22,color: Colors.black),),
                          Spacer(),
                          Text("Close".tr(),style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),

                    ],
                  ),),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen3(),));
                },
                child: Container(
                  padding: EdgeInsets.all(10),decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),),width: double.infinity,
                  height: 100,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25, // يمكنك تعديل الحجم هنا
                            backgroundImage: AssetImage("assets/images/d3.png",), // ضع مسار الصورة هنا
                          ),
                          SizedBox(width: 7,),
                          Text("AymanSamy".tr(),style: TextStyle(fontSize: 22,color: Colors.black),),
                          Spacer(),
                          Text("Online".tr(),style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),

                    ],
                  ),),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen4(),));
                },
                child: Container(
                  padding: EdgeInsets.all(10),decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),),width: double.infinity,
                  height: 85,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25, // يمكنك تعديل الحجم هنا
                            backgroundImage: AssetImage( "assets/images/d1.png",), // ضع مسار الصورة هنا
                          ),
                          SizedBox(width: 7,),
                          Text("JhoneEssa".tr(),style: TextStyle(fontSize: 22,color: Colors.black),),
                          Spacer(),
                          Text("Online".tr(),style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),

                    ],
                  ),),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen2(),));
                },
                child: Container(
                  padding: EdgeInsets.all(10),decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),),width: double.infinity,
                  height: 100,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25, // يمكنك تعديل الحجم هنا
                            backgroundImage: AssetImage( "assets/images/n1.jpg"), // ضع مسار الصورة هنا
                          ),
                          SizedBox(width: 7,),
                          Text("LilaAhmed".tr(),style: TextStyle(fontSize: 22,color: Colors.black),),
                          Spacer(),
                          Text("Close".tr(),style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),

                    ],
                  ),),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen3(),));
                },
                child: Container(
                  padding: EdgeInsets.all(10),decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),),width: double.infinity,
                  height: 100,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25, // يمكنك تعديل الحجم هنا
                            backgroundImage: AssetImage("assets/images/n3.jpg",), // ضع مسار الصورة هنا
                          ),
                          SizedBox(width: 7,),
                          Text("GanaAhmed".tr(),style: TextStyle(fontSize: 22,color: Colors.black),),
                          Spacer(),
                          Text("Online".tr(),style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),

                    ],
                  ),),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),));
                },
                child: Container(
                  padding: EdgeInsets.all(10),decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),),width: double.infinity,
                  height: 85,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25, // يمكنك تعديل الحجم هنا
                            backgroundImage: AssetImage( "assets/images/d1.png",), // ضع مسار الصورة هنا
                          ),
                          SizedBox(width: 7,),
                          Text("YaserAli".tr(),style: TextStyle(fontSize: 22,color: Colors.black),),
                          Spacer(),
                          Text("Close".tr(),style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),

                    ],
                  ),),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
