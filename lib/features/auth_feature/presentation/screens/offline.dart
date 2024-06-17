import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Offline extends StatefulWidget {
  const Offline({super.key});

  @override
  State<Offline> createState() => _OfflineState();
}

class _OfflineState extends State<Offline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200,left: 60,right: 60),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/offline.png"),
              SizedBox(height: 30,),
              TextWidget(title: "No network connection"),
              SizedBox(height: 30,),
              TextWidget(title: "Try again",titleColor: Colors.blueAccent,),

            ],
          ),
        ),
      ),
    );
  }
}
