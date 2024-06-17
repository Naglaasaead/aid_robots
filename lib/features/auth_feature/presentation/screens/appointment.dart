/*


import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/cancel_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../app/widgets/list_tile_widget.dart';
import '../../../../app/widgets/tap_bar_widget.dart';
import '../../../../app/widgets/text_button_widget.dart';
import 'button_nav_bar.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<String> searchResults = [];
  List <String> doctor = [
    "assets/images/d1.png",
    "assets/images/d2.png",
    "assets/images/d3.png",
    "assets/images/d1.png",
    "assets/images/d2.png",
    "assets/images/d3.png",
  ];
  List <String> titel = [
    "Dr. Randy Wigham",
    "Dr. Jack Sulivan",
    "Drg. Hanna Stanton",
    "Dr. Randy Wigham",
    "Dr. Jack Sulivan",
    "Drg. Hanna Stanton",
  ];
  List <String> Subtitel = [
    "General Medical Checkup",
    "General Medical Checkup",
    "General Medical Checkup",
    "General Medical Checkup",
    "General Medical Checkup",
    "General Medical Checkup",
  ];

  List <String> dateTime = [
    "Wed, 17 May | 08.30 AM",
    "Wed, 18 May | 10.10 AM",
    "Wed, 19 May | 05.15 AM",
    "Wed, 20 May | 12.20 AM",
    "Wed, 12 May | 08.00 AM",
    "Wed, 11 May | 03.30 AM",
  ];
  final TextEditingController _searchController = TextEditingController();

  List<Widget>  review = [
    Row(children: [
     Icon(Icons.star,color: Colors.yellow,),
      SizedBox(width: 5,),
     TextWidget(title: "4.8 (4,279 reviews)")
   ],),
    Row(children: [
      Icon(Icons.star,color: Colors.yellow,),
      SizedBox(width: 5,),
      TextWidget(title: "3.2 (4,279 reviews)")
    ],),
    Row(children: [
      Icon(Icons.star,color: Colors.yellow,),
      SizedBox(width: 5,),
      TextWidget(title: "7.8 (4,279 reviews)")
    ],),
    Row(children: [
      Icon(Icons.star,color: Colors.yellow,),
      SizedBox(width: 5,),
      TextWidget(title: "2.5 (4,279 reviews)")
    ],),
    Row(children: [
      Icon(Icons.star,color: Colors.yellow,),
      SizedBox(width: 5,),
      TextWidget(title: "5.6 (4,279 reviews)")
    ],),
    Row(children: [
      Icon(Icons.star,color: Colors.yellow,),
      SizedBox(width: 5,),
      TextWidget(title: "8.1 (4,279 reviews)")
    ],),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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
          */
/*  child: Center(
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
            ),*//*

          ),
        ),
     */
/*   title: Center(
          child: Container(
            child: TextWidget(
              title: 'My Appointment',
              titleFontWeight: FontWeight.bold,
              titleSize: 22,
              titleColor: Colors.black,
            ),
          ),
        ),*//*


        actions: [
*/
/*

            Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12),
              ),
              child:  IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  // Define what happens when the button is pressed.
                  print('Search icon pressed');
                },
              ),

            ),
          ),
*//*



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
                        // This function will be called every time the text in the search field changes
                        // You can perform the search here
                        // For now, let's just print the search term
                        print('Search term: $value');
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
                         String searchTerm = 'Your search term'; // Replace 'Your search term' with the actual search term

                        // Perform the search
                        List<String> searchResults = [];
                        for (int i = 0; i < titel.length; i++) {
                        if (titel[i].toLowerCase().contains(searchTerm.toLowerCase()) ||
                        Subtitel[i].toLowerCase().contains(searchTerm.toLowerCase())) {
                        // If either the title or subtitle contains the search term, add it to the search results
                        searchResults.add(titel[i]);
                        }
                        }

                        // Print or use the search results as needed
                        print('Search results: $searchResults');
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
          // "Upcoming"
          ListView.builder(
          itemCount: doctor.length,
            itemBuilder: (context, index) {
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
                        Image.asset(doctor[index]),
                        SizedBox(width: 13,),
                        DetailDoctors(titel: titel[index],
                            subTitel: Subtitel[index],
                            date: dateTime[index]),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: () {},
                        child: TextWidget(title: "Cancel Appointment",
                          titleSize: 14,
                          titleColor: Colors.blueAccent,),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(175, 35),
                          side: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      SizedBox(width: 5,),
                      ElevatedButton(
                        onPressed: () {},
                        child: TextWidget(title: "Reschedule",
                          titleSize: 16,
                          titleColor: Colors.white,),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          fixedSize: Size(175, 35),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
          //   "Completed"
          ListView.builder(
            itemCount: doctor.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            TextWidget(
                              title: "Appointment done",
                              titleColor: Colors.green,
                            ),
                            Row(
                              children: [
                                DetailDoctors(date: dateTime[index]),
                                Spacer(),
                               // SizedBox(width: 100,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(Icons.more_vert,color: Colors.grey,),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(width: double.infinity,height: 1,color: Colors.grey,),
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.only(left: 1,bottom: 15,top: 5),
                              child: Row(

                                children: [
                                  Image.asset(doctor[index]),
                                  SizedBox(width: 13,),
                                  Column(

                                    children: [
                                      TextWidget(title: titel[index],titleSize: 19,
                                        titleFontWeight: FontWeight.bold,
                                        titleColor: Colors.black,),
                                      TextWidget(title: Subtitel[index],titleSize: 16, titleColor: Colors.grey,),
                                      Row(
                                        children: [review[index]],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // الفارق بين العناصر
                  ],
                ),
              );
            },
          ),


          //    "Cancelled"
          ListView.builder(
            itemCount: doctor.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CancelAlert(),));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              TextWidget(
                                title: "Appointment Cancelled",
                                titleColor: Colors.red,
                              ),
                              Row(
                                children: [
                                  DetailDoctors(date: dateTime[index]),
                                  Spacer(),
                                  // SizedBox(width: 100,),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(Icons.more_vert,color: Colors.grey,),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(width: double.infinity,height: 1,color: Colors.grey,),
                              ),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.only(left: 1,bottom: 15,top: 5),
                                child: Row(

                                  children: [
                                    Image.asset(doctor[index]),
                                    SizedBox(width: 13,),
                                    Column(

                                      children: [
                                        TextWidget(title: titel[index],titleSize: 19,
                                          titleFontWeight: FontWeight.bold,
                                          titleColor: Colors.black,),
                                        TextWidget(title: Subtitel[index],titleSize: 16, titleColor: Colors.grey,),
                                        Row(
                                          children: [review[index]],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10), // الفارق بين العناصر
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),

        bottomNavigationBar: ButtonNavBar(initialIndex: 3)
    );
  }


  Padding DetailDoctors({String? titel, String? subTitel, String? date }) {
    return Padding(
      padding: const EdgeInsets.only(top: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (titel != null) TextWidget(title: titel,
                titleSize: 19,
                titleFontWeight: FontWeight.bold,
                titleColor: Colors.black,),
              SizedBox(width: 65,),
              if (titel != null) Icon(Icons.chat, color: Colors.blueAccent,),
            ],
          ),
          if (subTitel != null) TextWidget(
            title: subTitel, titleSize: 16, titleColor: Colors.grey,),
          if (date != null) TextWidget(
            title: date, titleSize: 16, titleColor: Colors.grey,),
        ],
      ),
    );
  }
}



*/













import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/cancel_alert.dart';
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
  List<String> doctor = [
    "assets/images/d1.png",
    "assets/images/d2.png",
    "assets/images/d3.png",
    "assets/images/d1.png",
    "assets/images/d2.png",
    "assets/images/d3.png",
  ];
  List<String> searchResults = [];
  List<String> titel = [
    "Dr. Randy Wigham",
    "Dr. Jack Sulivan",
    "Drg. Hanna Stanton",
    "Dr. Randy Wigham",
    "Dr. Jack Sulivan",
    "Drg. Hanna Stanton",
  ];
  List<String> Subtitel = [
    "General Medical Checkup",
    "General Medical Checkup",
    "General Medical Checkup",
    "General Medical Checkup",
    "General Medical Checkup",
    "General Medical Checkup",
  ];
  List<String> dateTime = [
    "Wed, 17 May | 08.30 AM",
    "Wed, 18 May | 10.10 AM",
    "Wed, 19 May | 05.15 AM",
    "Wed, 20 May | 12.20 AM",
    "Wed, 12 May | 08.00 AM",
    "Wed, 11 May | 03.30 AM",
  ];
  List<Widget> review = [
    Row(
      children: [
        Icon(Icons.star, color: Colors.yellow),
        SizedBox(width: 5),
        TextWidget(title: "4.8 (4,279 reviews)"),
      ],
    ),
    // Add more review widgets as needed
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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
    // Filter the data based on the search term
    searchResults = [];
    for (int i = 0; i < titel.length; i++) {
    if (titel[i].toLowerCase().contains(value.toLowerCase()) ||
    Subtitel[i].toLowerCase().contains(value.toLowerCase())) {
    searchResults.add(titel[i]);
    }
    }
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
    // Upcoming
    ListView.builder(
    itemCount: searchResults.isNotEmpty ? searchResults.length : doctor.length,
    itemBuilder: (context, index) {

    final itemIndex = searchResults.isNotEmpty ? titel.indexOf(searchResults[index]) : index;
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
              Image.asset(doctor[itemIndex]),
              SizedBox(width: 13),
              DetailDoctors(
                titel: titel[itemIndex],
                subTitel: Subtitel[itemIndex],
                date: dateTime[itemIndex],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
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
              onPressed: () {},
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
        ),
        SizedBox(height: 10),
      ],
    );
    },
    ),
      // Completed
      ListView.builder(
        itemCount: searchResults.isNotEmpty ? searchResults.length : doctor.length,
        itemBuilder: (context, index) {
          final itemIndex = searchResults.isNotEmpty ? titel.indexOf(searchResults[index]) : index;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        TextWidget(
                          title: "Appointment done",
                          titleColor: Colors.green,
                        ),
                        Row(
                          children: [
                            DetailDoctors(date: dateTime[itemIndex]),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.more_vert, color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(width: double.infinity, height: 1, color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 1, bottom: 15, top: 5),
                          child: Row(
                            children: [
                              Image.asset(doctor[itemIndex]),
                              SizedBox(width: 13),
                              Column(
                                children: [
                                  TextWidget(
                                    title: titel[itemIndex],
                                    titleSize: 19,
                                    titleFontWeight: FontWeight.bold,
                                    titleColor: Colors.black,
                                  ),
                                  TextWidget(
                                    title: Subtitel[itemIndex],
                                    titleSize: 16,
                                    titleColor: Colors.grey,
                                  ),
                                  Row(
                                    children: [review[itemIndex]],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
      // Cancelled
      ListView.builder(
        itemCount: searchResults.isNotEmpty ? searchResults.length : doctor.length,
        itemBuilder: (context, index) {
          final itemIndex = searchResults.isNotEmpty ? titel.indexOf(searchResults[index]) : index;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CancelAlert()));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          TextWidget(
                            title: "Appointment Cancelled",
                            titleColor: Colors.red,
                          ),
                          Row(
                            children: [
                              DetailDoctors(date: dateTime[itemIndex]),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(Icons.more_vert, color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(width: double.infinity, height: 1, color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 1, bottom: 15, top: 5),
                            child: Row(
                              children: [
                                Image.asset(doctor[itemIndex]),
                                SizedBox(width: 13),
                                Column(
                                  children: [
                                    TextWidget(
                                      title: titel[itemIndex],
                                      titleSize: 19,
                                      titleFontWeight: FontWeight.bold,
                                      titleColor: Colors.black,
                                    ),
                                    TextWidget(
                                      title: Subtitel[itemIndex],
                                      titleSize: 16,
                                      titleColor: Colors.grey,
                                    ),
                                    Row(
                                      children: [review[itemIndex]],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    ],
    ),
      bottomNavigationBar: ButtonNavBar(initialIndex: 3),
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
    if (titel != null) TextWidget
        (
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

