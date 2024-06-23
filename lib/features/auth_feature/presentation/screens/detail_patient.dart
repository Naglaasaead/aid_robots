import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'button_nav_bar.dart';

class DeatailPatient extends StatefulWidget {
  const DeatailPatient({super.key, required this.name, required this.status,});
  final String name;
  final String status;

  @override
  State<DeatailPatient> createState() => _DeatailPatientState();
}

class _DeatailPatientState extends State<DeatailPatient> {
  List<String> imagePatien = [
    "assets/images/pat2.jpeg",
    "assets/images/pat3.jpeg",
    "assets/images/pat4.jpeg",
    "assets/images/pat5.jpeg",
    "assets/images/pat6.jpeg",
    "assets/images/pat7.jpeg",
    "assets/images/pat8.jpeg",
    "assets/images/pat9.jpeg",
    "assets/images/pat10.jpeg",
    "assets/images/pat3.jpeg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: TextWidget(title: "Deatail Patein",titleColor: Colors.black,titleSize: 25,)),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: Image.asset(
                    imagePatien.isNotEmpty ? imagePatien[0] : "",
                    width: 350,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                TextWidget(
                  title: "Name  : ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: TextWidget(
                    title: widget.name,
                    titleSize: 22,
                    titleColor: Colors.red, // تحديد لون النص الأحمر هنا
                    titleFontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                TextWidget(
                  title: "Room Number  : ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: TextWidget(
                    title: " 1",
                    titleSize: 22,
                    titleColor: Colors.red, // تحديد لون النص الأحمر هنا
                    titleFontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                TextWidget(
                  title: "Age  : ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 72),
                  child: TextWidget(
                    title: " 30",
                    titleSize: 22,
                    titleColor: Colors.red, // تحديد لون النص الأحمر هنا
                    titleFontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                TextWidget(
                  title: "Status  : ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 43),
                  child: TextWidget(
                    title: widget.status,
                    titleSize: 22,
                    titleColor: Colors.red, // تحديد لون النص الأحمر هنا
                    titleFontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                TextWidget(
                  title: "Medicament Name  : ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 43),
                  child: TextWidget(
                    title: " Glyburid",
                    titleSize: 22,
                    titleColor: Colors.red, // تحديد لون النص الأحمر هنا
                    titleFontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                TextWidget(
                  title: "Number of doses  : ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: TextWidget(
                    title: " 3",
                    titleSize: 22,
                    titleColor: Colors.red, // تحديد لون النص الأحمر هنا
                    titleFontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                TextWidget(
                  title: "Time of the first dose  : ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: TextWidget(
                    title: " 8 : 00 AM",
                    titleSize: 22,
                    titleColor: Colors.red, // تحديد لون النص الأحمر هنا
                    titleFontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                TextWidget(
                  title: "Time of the Seconed dose  : ",
                  titleSize: 20,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: TextWidget(
                    title: " 3 : 00 BM",
                    titleSize: 20,
                    titleColor: Colors.red, // تحديد لون النص الأحمر هنا
                    titleFontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                TextWidget(
                  title: "Time of the first dose  : ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextWidget(
                    title: " 11 : 00 BM",
                    titleSize: 22,
                    titleColor: Colors.red, // تحديد لون النص الأحمر هنا
                    titleFontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),





          ],
        ),
      ),
        bottomNavigationBar: ButtonNavBar(initialIndex: 1)
    );
  }
}
