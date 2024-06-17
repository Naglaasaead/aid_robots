/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Function(BuildContext) onPressed; // تم تغيير هنا إلى required
  CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed, // تم تغيير هنا إلى required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed(context);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Container(
        width: 250,
        child: Center(
          child: Text(text!, style: TextStyle(color: Colors.white,fontSize: 22),),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Function(BuildContext) onPressed; // تم تغيير هنا إلى required
  CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed, // تم تغيير هنا إلى required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed(context); // هنا يتم استخدام context كمعامل للدالة onPressed
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Container(
        width: 250,
        child: Center(
          child: Text(text!, style: TextStyle(color: Colors.white,fontSize: 22),),
        ),
      ),
    );
  }
}
