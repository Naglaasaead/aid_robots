
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



/*

import 'package:flutter/material.dart';
import 'package:aid_robot/app/widgets/text_widget.dart';
import 'button_nav_bar.dart';

class DetailPatient extends StatefulWidget {
  final String name;
  final String status;
  final String roomNumber;
  final String age;
  final String medicamentName;
  final String numberOfDoses;
  final String timeOfFirstDose;
  final String timeOfSecondDose;
  final String timeOfThirdDose;

  const DetailPatient({
    Key? key,
    required this.name,
    required this.status,
    required this.roomNumber,
    required this.age,
    required this.medicamentName,
    required this.numberOfDoses,
    required this.timeOfFirstDose,
    required this.timeOfSecondDose,
    required this.timeOfThirdDose,
  }) : super(key: key);

  @override
  _DetailPatientState createState() => _DetailPatientState();
}

class _DetailPatientState extends State<DetailPatient> {
  late String _currentName;
  late String _currentStatus;
  late String _currentRoomNumber;
  late String _currentAge;
  late String _currentMedicamentName;
  late String _currentNumberOfDoses;
  late String _currentTimeOfFirstDose;
  late String _currentTimeOfSecondDose;
  late String _currentTimeOfThirdDose;

  @override
  void initState() {
    super.initState();
    // Initialize current data with the provided data
    _currentName = widget.name;
    _currentStatus = widget.status;
    _currentRoomNumber = widget.roomNumber;
    _currentAge = widget.age;
    _currentMedicamentName = widget.medicamentName;
    _currentNumberOfDoses = widget.numberOfDoses;
    _currentTimeOfFirstDose = widget.timeOfFirstDose;
    _currentTimeOfSecondDose = widget.timeOfSecondDose;
    _currentTimeOfThirdDose = widget.timeOfThirdDose;
  }

  void updatePatientData({
    String? name,
    String? status,
    String? roomNumber,
    String? age,
    String? medicamentName,
    String? numberOfDoses,
    String? timeOfFirstDose,
    String? timeOfSecondDose,
    String? timeOfThirdDose,
  }) {
    setState(() {
      // Update current data with new values (if provided)
      if (name != null) _currentName = name;
      if (status != null) _currentStatus = status;
      if (roomNumber != null) _currentRoomNumber = roomNumber;
      if (age != null) _currentAge = age;
      if (medicamentName != null) _currentMedicamentName = medicamentName;
      if (numberOfDoses != null) _currentNumberOfDoses = numberOfDoses;
      if (timeOfFirstDose != null) _currentTimeOfFirstDose = timeOfFirstDose;
      if (timeOfSecondDose != null) _currentTimeOfSecondDose = timeOfSecondDose;
      if (timeOfThirdDose != null) _currentTimeOfThirdDose = timeOfThirdDose;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: "Patient Details",
          titleSize: 25,
          titleColor: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: Image.asset(
                    "assets/images/pat2.jpeg", // Placeholder image
                    width: 350,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                TextWidget(
                  title: "Name: ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                SizedBox(width: 10),
                TextWidget(
                  title: _currentName,
                  titleSize: 22,
                  titleColor: Colors.red,
                  titleFontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                TextWidget(
                  title: "Status: ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                SizedBox(width: 10),
                TextWidget(
                  title: _currentStatus,
                  titleSize: 22,
                  titleColor: Colors.red,
                  titleFontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                TextWidget(
                  title: "Room Number: ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                SizedBox(width: 10),
                TextWidget(
                  title: _currentRoomNumber,
                  titleSize: 22,
                  titleColor: Colors.red,
                  titleFontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                TextWidget(
                  title: "Age: ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                SizedBox(width: 10),
                TextWidget(
                  title: _currentAge,
                  titleSize: 22,
                  titleColor: Colors.red,
                  titleFontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                TextWidget(
                  title: "Medicament Name: ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                SizedBox(width: 10),
                TextWidget(
                  title: _currentMedicamentName,
                  titleSize: 22,
                  titleColor: Colors.red,
                  titleFontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                TextWidget(
                  title: "Number of Doses: ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                SizedBox(width: 10),
                TextWidget(
                  title: _currentNumberOfDoses,
                  titleSize: 22,
                  titleColor: Colors.red,
                  titleFontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                TextWidget(
                  title: "Time of First Dose: ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                SizedBox(width: 10),
                TextWidget(
                  title: _currentTimeOfFirstDose,
                  titleSize: 22,
                  titleColor: Colors.red,
                  titleFontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                TextWidget(
                  title: "Time of Second Dose: ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                SizedBox(width: 10),
                TextWidget(
                  title: _currentTimeOfSecondDose,
                  titleSize: 22,
                  titleColor: Colors.red,
                  titleFontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                TextWidget(
                  title: "Time of Third Dose: ",
                  titleSize: 22,
                  titleColor: Colors.black,
                  titleFontWeight: FontWeight.bold,
                ),
                SizedBox(width: 10),
                TextWidget(
                  title: _currentTimeOfThirdDose,
                  titleSize: 22,
                  titleColor: Colors.red,
                  titleFontWeight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: ButtonNavBar(initialIndex: 1),
    );
  }
}
*/
