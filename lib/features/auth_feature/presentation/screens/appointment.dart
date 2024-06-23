import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/cancel_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    "assets/images/d1.png",
    "assets/images/d2.png",
    "assets/images/d3.png",
    "assets/images/d1.png",
    "assets/images/d2.png",
    "assets/images/d3.png",
  ];
  List<Map<String, dynamic>> doctors = [];
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    getData();
    addData();
    tabController = TabController(length: 3, vsync: this);
  }

  Future<void> getData() async {
    CollectionReference doctorRef = FirebaseFirestore.instance.collection('Doctors');
    QuerySnapshot querySnapshot = await doctorRef.get();
    setState(() {
      doctors = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
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
  Future<void> showLoading(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              Container(height:50,child: Center(child: CircularProgressIndicator())),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
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
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
          onTap: (index) {
            print('Tapped on tab $index');
          },
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          buildListView(searchResults.isNotEmpty ? searchResults : doctors, true),
          buildListView(searchResults.isNotEmpty ? searchResults : doctors, false),
          buildListView(searchResults.isNotEmpty ? searchResults : doctors, false),
        ],
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
              isUpcoming ? Row(
                children: [
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      addData();
                    },
                    child: TextWidget(
                      title: "Cancel Appointment",
                      titleSize: 14,
                      titleColor: Colors.blueAccent,
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
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Patient()),
                      );*/
                    },
                    child: TextWidget(
                      title: "Reschedule",
                      titleSize: 16,
                      titleColor: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      fixedSize: Size(175, 35),
                    ),
                  ),

                ],
              ) : Container(),
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
              if (titel != null) TextWidget(
                title: titel,
                titleSize: 19,
                titleFontWeight: FontWeight.bold,
                titleColor: Colors.black,
              ),
              SizedBox(width: 65),
              if (titel != null) Icon(Icons.chat, color: Colors.blueAccent),
            ],
          ),
          if (subTitel != null) TextWidget(
            title: subTitel,
            titleSize: 16,
            titleColor: Colors.grey,
          ),
          if (date != null) TextWidget(
            title: date,
            titleSize: 16,
            titleColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
