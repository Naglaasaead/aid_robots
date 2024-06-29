import 'package:aid_robot/features/auth_feature/presentation/screens/home_patient.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/patients.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'allChat.dart';
import 'appointment.dart';
import 'login.dart';

class RolePage extends StatefulWidget {
  const RolePage({Key? key}) : super(key: key);

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_outlined),
        onPressed: () {


           if (_selectedValue != null) {
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => LoginScreens(_selectedValue!)),
             );
           }
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/img5.png"),
              SizedBox(height: 30),
              Text("TailorExperience".tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              SizedBox(height: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("good".tr(),
                      style: TextStyle(fontSize: 20, color: Colors.grey)),
                  Text("experience".tr(),
                      style: TextStyle(fontSize: 20, color: Colors.grey)),
                  Text("Blow".tr(),
                      style: TextStyle(fontSize: 20, color: Colors.grey)),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RadioListTile<String>(
                          title: Text('Patient'.tr()),
                          value: 'patient',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('doctor'.tr()),
                          value: 'doctor',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Nurse'.tr()),
                          value: 'nurse',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Manager'.tr()),
                          value: 'manager',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';

// قم بتضمين الشاشات الأخرى
import 'allChat.dart';
import 'patients.dart';
import 'appointment.dart';
import 'home_patient.dart';

class RolePage extends StatefulWidget {
  const RolePage({Key? key}) : super(key: key);

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_outlined),
        onPressed: () {
          if (_selectedValue != null) {
            // تحديد الشاشة بناءً على القيمة المحددة
            Widget nextPage;
            switch (_selectedValue) {
              case 'Option 1':
                nextPage = AllChatUser();
                break;
              case 'Option 2':
                nextPage = Patient();
                break;
              case 'Option 3':
                nextPage = Appointment();
                break;
              case 'Option 4':
                nextPage = HomePatient();
                break;
              default:
                nextPage = RolePage(); // أو أي شاشة افتراضية تريدها
            }

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          }
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/img5.png"),
              SizedBox(height: 30),
              Text("Tailor Your Experience",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              SizedBox(height: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("To provide you with good ",
                      style: TextStyle(fontSize: 20, color: Colors.grey)),
                  Text(" experience, please select your ",
                      style: TextStyle(fontSize: 20, color: Colors.grey)),
                  Text(" role below: ",
                      style: TextStyle(fontSize: 20, color: Colors.grey)),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RadioListTile<String>(
                          title: Text('I am a Patient'),
                          value: 'Option 1',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('I am a Doctor'),
                          value: 'Option 2',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('I am a Nurse'),
                          value: 'Option 3',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('I am a Manager'),
                          value: 'Option 4',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
