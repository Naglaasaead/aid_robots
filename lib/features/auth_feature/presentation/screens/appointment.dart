/*
import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/cancel_alert.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/patient2.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/patient3.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/patient4.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/patient5.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/patients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Patient6.dart';
import 'button_nav_bar.dart';
import 'chat1.dart';
import 'chat2.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController _searchController = TextEditingController();
  List<String> doctorImages = [
    "assets/images/n1.jpg",
    "assets/images/n2.jpg",
    "assets/images/d3.png",
    "assets/images/d1.png",
    "assets/images/d2.png",
    "assets/images/n3.jpg",
  ];
  List<Map<String, dynamic>> doctors = [];
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    CollectionReference doctorRef = FirebaseFirestore.instance.collection('Doctors');
    QuerySnapshot querySnapshot = await doctorRef.get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  addData() async {
    try {
      CollectionReference doctorRef = FirebaseFirestore.instance.collection('Doctors').doc('0fC8xpHzusql4RhzZIpz').collection('patient_naglaa');
      await doctorRef.add({
        "specialization": "surgery",
        "username": "Ahmed",
      });
      print("Data added successfully");
    } catch (e) {
      print("Failed to add data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black12),
            ),
          ),
        ),
        actions: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          searchResults = doctors.where((doctor) {
                            return doctor['username'].toLowerCase().contains(value.toLowerCase()) ||
                                doctor['specialization'].toLowerCase().contains(value.toLowerCase());
                          }).toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        // Perform any action here when search button is pressed
                        print('Search icon pressed');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'Upcoming'),
            Tab(text: 'OffLine'),
            Tab(text: 'Cancelled'),
          ],
          onTap: (index) {
            print('Tapped on tab $index');
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            doctors = snapshot.data!;
            return TabBarView(
              controller: tabController,
              children: [
                buildListView(searchResults.isNotEmpty ? searchResults : doctors, true),
                buildListView(searchResults.isNotEmpty ? searchResults : doctors, false),
                buildListView(searchResults.isNotEmpty ? searchResults : doctors, false),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: ButtonNavBar(initialIndex: 3),
    );
  }

  Widget buildListView(List<dynamic> data, bool isUpcoming) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (data is List<Map<String, dynamic>>) {
          final doctor = data[index];
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.only(left: 20),
                height: 120,
                child: Row(
                  children: [
                    Image.asset(doctorImages[index % doctorImages.length]),
                    SizedBox(width: 13),
                    DetailDoctors(
                      titel: doctor['username'],
                      subTitel: doctor['specialization'],
                      date: "Wed, 17 May | 08.30 AM", // Placeholder date
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              isUpcoming
                  ? Row(
                children: [
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      addData();
                    },
                    child: Text(
                      "Cancel Appointment",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(175, 35),
                      side: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          switch (index % 6) {
                            case 0:
                              return Patient();
                            case 1:
                              return Patient2();
                            case 2:
                              return Patient3();
                            case 3:
                              return Patient4();
                            case 4:
                              return Patient5();
                            default:
                              return Patient6();
                          }
                        }),
                      );
                    },
                    child: Text(
                      "Reschedule",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      fixedSize: Size(175, 35),
                    ),
                  ),
                ],
              )
                  : Container(),
              SizedBox(height: 10),
            ],
          );
        } else {
          // Handle the case where data is List<String> (for doctorImages)
          final imagePath = data[index];
          return Container(
            height: 120,
            width: double.infinity,
            child: Image.asset(imagePath),
          );
        }
      },
    );
  }

  Padding DetailDoctors({String? titel, String? subTitel, String? date}) {
    return Padding(
      padding: const EdgeInsets.only(top: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (titel != null)
                Text(
                  titel,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              SizedBox(width: 65),
              //if (titel != null) Icon(Icons.chat, color: Colors.blueAccent),
            ],
          ),
          if (subTitel != null)
            Text(
              subTitel,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          if (date != null)
            Text(
              date,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
*/


/*
import 'package:aid_robot/features/auth_feature/presentation/screens/patients.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'Patient2.dart';
import 'Patient3.dart';
import 'Patient4.dart';
import 'Patient5.dart';
import 'Patient6.dart';
import 'button_nav_bar.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController _searchController = TextEditingController();
  List<String> doctorImages = [
    "assets/images/n2.jpg",
    "assets/images/n3.jpg",
    "assets/images/d1.png",
    "assets/images/d3.png",
    "assets/images/d2.png",
    "assets/images/n1.jpg",
  ];
  List<Map<String, dynamic>> doctors = [];
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    CollectionReference doctorRef = FirebaseFirestore.instance.collection('Doctors');
    QuerySnapshot querySnapshot = await doctorRef.get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  addData() async {
    try {
      CollectionReference doctorRef = FirebaseFirestore.instance.collection('Doctors').doc('0fC8xpHzusql4RhzZIpz').collection('patient_naglaa');
      await doctorRef.add({
        "specialization": "surgery",
        "username": "Ahmed",
      });
      print("Data added successfully");
    } catch (e) {
      print("Failed to add data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black12),
            ),
          ),
        ),
        actions: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          searchResults = doctors.where((doctor) {
                            return doctor['username'].toLowerCase().contains(value.toLowerCase()) ||
                                doctor['specialization'].toLowerCase().contains(value.toLowerCase());
                          }).toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search'.tr(),
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        // Perform any action here when search button is pressed
                        print('Search icon pressed');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'Upcoming'.tr()),
            Tab(text: 'availableNow'.tr()),
            Tab(text: 'unAvalibale'.tr()),
          ],
          onTap: (index) {
            print('Tapped on tab $index');
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'.tr()));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('NotData'.tr()));
          } else {
            doctors = snapshot.data!;
            return TabBarView(
              controller: tabController,
              children: [
                buildListView(searchResults.isNotEmpty ? searchResults : doctors, true),
                buildListView(searchResults.isNotEmpty ? searchResults : doctors, false),
                buildListView(searchResults.isNotEmpty ? searchResults : doctors, false),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: ButtonNavBar(initialIndex: 3),
    );
  }

  Widget buildListView(List<dynamic> data, bool isUpcoming) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (data is List<Map<String, dynamic>>) {
          final doctor = data[index];
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 120,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Adjust border radius here
                      child: Image.asset(
                        doctorImages[index % doctorImages.length],
                        fit: BoxFit.cover, // Ensure all images have the same size
                        width: 80, // Fixed width for consistency
                        height: 80, // Fixed height for consistency
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: DetailDoctors(
                        titel: doctor['username'].toString().tr(),
                        subTitel: doctor['specialization'].toString().tr(),
                        date: "Wed, 17 May | 08.30 AM".toString().tr(), // Placeholder date
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              isUpcoming
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      addData();
                    },
                    child: Text(
                      "Yellow".tr(),
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(175, 35),
                      side: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          switch (index % 6) {
                            case 0:
                              return Patient();
                            case 1:
                              return Patient2();
                            case 2:
                              return Patient3();
                            case 3:
                              return Patient4();
                            case 4:
                              return Patient5();
                            default:
                              return Patient6();
                          }
                        }),
                      );
                    },
                    child: Text(
                      "Reschedule".tr(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      fixedSize: Size(175, 35),
                    ),
                  ),
                ],
              )
                  : Container(),
              SizedBox(height: 10),
            ],
          );
        } else {
          // Handle the case where data is List<String> (for doctorImages)
          final imagePath = data[index];
          return Container(
            height: 120,
            width: double.infinity,
            child: Image.asset(imagePath),
          );
        }
      },
    );
  }

  Padding DetailDoctors({String? titel, String? subTitel, String? date}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titel != null)
            Text(
              titel,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          SizedBox(height: 5),
          if (subTitel != null)
            Text(
              subTitel,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          if (date != null)
            Text(
              date,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
*/


import 'package:aid_robot/features/auth_feature/presentation/screens/patients.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Patient2.dart';
import 'Patient3.dart';
import 'Patient4.dart';
import 'Patient5.dart';
import 'Patient6.dart';
import 'button_nav_bar.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController _searchController = TextEditingController();
  List<String> doctorImages = [
    "assets/images/n2.jpg",
    "assets/images/n3.jpg",
    "assets/images/d1.png",
    "assets/images/d3.png",
    "assets/images/d2.png",
    "assets/images/n1.jpg",
  ];
  List<Map<String, dynamic>> doctors = [];
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    CollectionReference doctorRef = FirebaseFirestore.instance.collection('Doctors');
    QuerySnapshot querySnapshot = await doctorRef.get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  addData() async {
    try {
      CollectionReference doctorRef = FirebaseFirestore.instance.collection('Doctors').doc('0fC8xpHzusql4RhzZIpz').collection('patient_naglaa');
      await doctorRef.add({
        "specialization": "surgery",
        "username": "Ahmed",
      });
      print("Data added successfully");
    } catch (e) {
      print("Failed to add data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black12),
            ),
          ),
        ),
        actions: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          searchResults = doctors.where((doctor) {
                            return doctor['username'].toLowerCase().contains(value.toLowerCase()) ||
                                doctor['specialization'].toLowerCase().contains(value.toLowerCase());
                          }).toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search'.tr(),
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        // Perform any action here when search button is pressed
                        print('Search icon pressed');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'Upcoming'.tr()),
            Tab(text: 'availableNow'.tr()),
            Tab(text: 'unAvalibale'.tr()),
          ],
          onTap: (index) {
            print('Tapped on tab $index');
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'.tr()));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('NotData'.tr()));
          } else {
            doctors = snapshot.data!;
            return TabBarView(
              controller: tabController,
              children: [
                buildListView(searchResults.isNotEmpty ? searchResults : doctors, true),
                buildListView(searchResults.isNotEmpty ? searchResults : doctors, false),
                buildListView(searchResults.isNotEmpty ? searchResults : doctors, false),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: ButtonNavBar(initialIndex: 3),
    );
  }

  Widget buildListView(List<dynamic> data, bool isUpcoming) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (data is List<Map<String, dynamic>>) {
          final doctor = data[index];
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 120,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Adjust border radius here
                      child: Image.asset(
                        doctorImages[index % doctorImages.length],
                        fit: BoxFit.cover, // Ensure all images have the same size
                        width: 80, // Fixed width for consistency
                        height: 80, // Fixed height for consistency
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: DetailDoctors(
                        titel: doctor['username'].toString().tr(),
                        subTitel: doctor['specialization'].toString().tr(),
                        date: "Wed, 17 May | 08.30 AM".toString().tr(), // Placeholder date
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              isUpcoming
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      addData();
                    },
                    child: Text(
                      "Yellow".tr(),
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(175, 35),
                      side: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          switch (index % 6) {
                            case 0:
                              return Patient();
                            case 1:
                              return Patient2();
                            case 2:
                              return Patient3();
                            case 3:
                              return Patient4();
                            case 4:
                              return Patient5();
                            default:
                              return Patient6();
                          }
                        }),
                      );
                    },
                    child: Text(
                      "Reschedule".tr(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      fixedSize: Size(175, 35),
                    ),
                  ),
                ],
              )
                  : Container(),
              SizedBox(height: 10),
            ],
          );
        } else {
          // Handle the case where data is List<String> (for doctorImages)
          final imagePath = data[index];
          return Container(
            height: 120,
            width: double.infinity,
            child: Image.asset(imagePath),
          );
        }
      },
    );
  }

  Padding DetailDoctors({String? titel, String? subTitel, String? date}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titel != null)
            Text(
              titel!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          SizedBox(height: 5),
          if (subTitel != null)
            Text(
              subTitel!,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          if (date != null)
            Text(
              date!,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
