import 'package:aid_robot/features/auth_feature/presentation/screens/allChat.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/patients.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/pop_up.dart';
import 'package:flutter/material.dart';

import 'appointment.dart';
import 'home_patient.dart';

class ButtonNavBar extends StatefulWidget {
  final int initialIndex;

  const ButtonNavBar({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _ButtonNavBarState createState() => _ButtonNavBarState();
}

class _ButtonNavBarState extends State<ButtonNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePatient(),
    AllChatUser(),
    Patient(),
    Appointment(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        // استخدام Navigator للانتقال إلى الصفحة المناسبة
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => _pages[index]));
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mic_external_on_outlined),
          label: 'Patient',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Doctor',
        ),
      ],
      selectedIconTheme: IconThemeData(color: Colors.blue, size: 30), // لون وحجم الرموز المحددة
      unselectedIconTheme: IconThemeData(color: Colors.blue), // لون وحجم الرموز غير المحددة
      backgroundColor: Colors.blueAccent,
      fixedColor: Colors.blue,
      // خلفية الزر
    );
  }
}
