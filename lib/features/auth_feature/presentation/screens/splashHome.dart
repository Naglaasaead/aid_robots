import 'package:flutter/material.dart';

class SplashHome extends StatelessWidget {
  const SplashHome({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           // Image.asset("assets/images/logo4.png"),
            Image.asset("assets/images/logo1.png"),
            SizedBox(height: 5,),
            Center(child: Image.asset("assets/images/logo2.png",width: 300,)),
          ],
        ),
      ),
    );
  }
}
