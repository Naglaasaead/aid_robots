import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool _iconBool = false;
IconData  _lightMode= Icons.wb_sunny;
IconData _darkMode = Icons.nights_stay;
ThemeData _lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.light,
  buttonTheme: ButtonThemeData(buttonColor: Colors.amberAccent),
);
ThemeData _darkTheme = ThemeData(
  primarySwatch: Colors.red,
  brightness: Brightness.dark,
);

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _iconBool = !_iconBool; //
              });
            },
            icon: Icon(_iconBool ? _darkMode : _lightMode),
          ),
        ],
      ),
    );
  }
}
