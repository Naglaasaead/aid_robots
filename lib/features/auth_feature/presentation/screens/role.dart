import 'package:flutter/material.dart';

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
              MaterialPageRoute(builder: (context) => LoginScreens()),
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
