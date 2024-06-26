import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Chat2 extends StatefulWidget {
  const Chat2({super.key});

  @override
  State<Chat2> createState() => _Chat2State();
}

Future<void> urlLauncher(String name) async {
  String urlString = '';
  if (name == "phone") {
    urlString = "tel:+201550344738";
  } else if (name == "facebook") {
    urlString = "https://www.facebook.com/profile";
  }
  else if (name == "whatsApp") {
    urlString =  "https://wa.me/201550344738";
  }

  Uri url = Uri.parse(urlString);

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw Exception('Could not launch $urlString');
  }
}

class _Chat2State extends State<Chat2> {
  TextEditingController text = TextEditingController();
  String myname = "Chat_2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(child: Text("Chat 2")),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Center(
           child: InkWell(
             onTap: () {
               urlLauncher('phone');
             },
             child: Container(
               width: 50,
               height: 50,
               padding: EdgeInsets.all(4.0),
               margin: EdgeInsets.all(8.0),
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 color: Colors.green,
               ),
               child: Icon(Icons.phone, color: Colors.white),
             ),
           ),
         ),
         SizedBox(height: 5,),
         Center(
           child: InkWell(
             onTap: () {
               urlLauncher('facebook');
             },
             child: Container(
               width: 50,
               height: 50,
               padding: EdgeInsets.all(4.0),
               margin: EdgeInsets.all(8.0),
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 color: Colors.blue,
               ),
               child: Icon(Icons.facebook, color: Colors.white),
             ),
           ),
         ),
         Center(
           child: InkWell(
             onTap: () {
               urlLauncher('whatsApp');
             },
             child: Container(
               width: 50,
               height: 50,
               padding: EdgeInsets.all(4.0),
               margin: EdgeInsets.all(8.0),
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 color: Colors.blue,
               ),
               child: Icon(Icons.waving_hand, color: Colors.green),
             ),
           ),
         ),
       ],

      ),
    );
  }
}
