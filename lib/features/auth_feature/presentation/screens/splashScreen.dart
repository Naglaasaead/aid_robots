import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../app/utils/helper.dart';
import 'onBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showInitialImages = true;

  @override
  void initState() {
    super.initState();
    // Start the delay
    _startDelay();
  }

  void _startDelay() {
    // Delay for 3 seconds
    Timer(Duration(seconds: 3), () {
      // After 3 seconds, set _showInitialImages to false to remove the initial images
      setState(() {
        _showInitialImages = false;
      });
      // After 3 seconds, navigate to the next screen
      Timer(Duration(seconds: 3), () {
        navigateTo(BoardingScreen(), replace: true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show initial images if _showInitialImages is true
          if (_showInitialImages)
            Column(
              children: [
                Image.asset("assets/images/logo1.png"),
                SizedBox(height: 8),
                Center(child: Image.asset("assets/images/logo2.png", width: 300)),
              ],
            ),
          // Show the new image after 3 seconds
          if (!_showInitialImages)
            Center(child: Image.asset("assets/images/logo4.png")),
        ],
      ),
    );
  }
}
