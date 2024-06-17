
import 'dart:core';

import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'button_nav_bar.dart';
import 'detail_patient.dart';

class Patient extends StatefulWidget {
  const Patient({Key? key});

  @override
  State<Patient> createState() => _patientState();
}

class _patientState extends State<Patient> {
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
  List<String> namePatient = [
    "Naglaa Saeed",
    "Basmala Moustafa ",
    "Amr Mohamed",
    "Adham Essam",
    "Shady Mohamed",
    "Seif Al-dein",
    "Ahmed Reda",
    "Sama Maher",
    "Rahaf Ahmed",
    "Zain Mostafa",
  ];
  List<String> status = [
    "Status is diabetic",
    "Status is Status is Heart ",
    "Status is A blood pressure ",
    "Status is High temperature",
    "Status is diabetic",
    "Status is Heart patient",
    "Status is A blood pressure ",
    "Status is High temperature",
    "Status is Heart patient",
    "Status is A blood pressure ",
  ];
  late   int index=0;
  List<String> dateTime = [];

  bool showNewPatient = false;

  @override
  Widget build(BuildContext context) {
    void _deletePatient( index) {
      setState(() {
        imagePatien.removeAt(index);
        namePatient.removeAt(index);
        status.removeAt(index);
        dateTime.removeAt(index);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            " All Patient ",
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showNewPatient = true;
              });
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.update),
          ),
          IconButton(
            onPressed: () {
              // حذف العنصر المحدد من القائمة
              setState(() {
                _deletePatient(index);
              });
            },
            icon: Icon(Icons.delete),
          ),


        ],
      ),
      body: ListView.builder(
        itemCount: imagePatien.length + (showNewPatient ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == imagePatien.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 120,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.only(left: 20),
                  child: Center(
                    child: Text(
                      "New Patient",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            );
          } else {
            // عرض بيانات المريض
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DeatailPatient(),));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.only(left: 20),
                  height: 120,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          imagePatien[index],
                          width: 70,
                          height: 70,
                        ),
                      ),
                      SizedBox(width: 13),
                      Expanded(
                        child: DetailDoctors(
                          titel: namePatient[index],
                          subTitel: status[index],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
        bottomNavigationBar: ButtonNavBar(initialIndex: 2)
    );
  }
}

class DetailDoctors extends StatelessWidget {
  final String? titel;
  final String? subTitel;
  final String? date;

  const DetailDoctors({
    Key? key,
    this.titel,
    this.subTitel,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 26),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    if (titel != null)
    TextWidget(
    title: titel!,
    titleSize: 19,
    titleFontWeight: FontWeight.bold,
    titleColor: Colors.black,
    ),
    SizedBox(width: 65),
    ],
    ),

    if (subTitel != null)
    TextWidget(
    title: subTitel!,
    titleSize: 19,
    titleFontWeight: FontWeight.bold,
    titleColor: Colors.grey,
    ),
    if (date != null)
    TextWidget(
    title: date!,
    titleSize: 13,
    titleFontWeight: FontWeight.bold,
    titleColor: Colors.grey,
    ),
    ],
    ),
    );
  }
}












