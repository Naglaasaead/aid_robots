import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseNotification{
  //create instance
  //FirebaseMessaging messing=FirebaseMessaging.instance;
  getToken ()async{
    String? myToket = await FirebaseMessaging.instance.getToken();
    print("=======================");
    print(myToket);
  }


}