import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'button_nav_bar.dart';

class HomePatient extends StatefulWidget {
  final token;
   HomePatient({super.key,@required this.token, });

  @override
  State<HomePatient> createState() => _HomePatientState();
}

class _HomePatientState extends State<HomePatient> {
  late String email;

  List img=[
    "assets/images/view.png",
    "assets/images/login_in.png",
    "assets/images/view.png",
    "assets/images/login_in.png",
  ];
  List <String> spice=[
        "assets/images/img1.png",
        "assets/images/img2.png",
        "assets/images/img33.png",
        "assets/images/img4.png",
        "assets/images/img55.png",
        "assets/images/img6.png",
        "assets/images/img1.png",
       "assets/images/img2.png",
       "assets/images/img33.png",
  ];
  late int currentImagePath;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // Map<String,dynamic> jwtDecodeToken=JwtDecoder.decode(widget.token);
    {

     // email=jwtDecodeToken['email'];
    };
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [Padding(
            padding: const EdgeInsets.only(top: 10,right: 25),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined)),
          )],
          title: Padding(
            padding: const EdgeInsets.only(top: 20,),
            child: Text("Naglaa".tr(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black),),
          ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20),
          child: CircleAvatar(
          child: Image.asset('assets/images/User icon.png'),
          ),
        ),),
    body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
            children: [
                 //Search
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFFF3F2E9),
                ),
                child: Padding(

                  padding: const EdgeInsets.all(10.0),

                  child: Row(
                    children: [
                      TextWidget( title: 'Search'.tr(),titleColor: Colors.grey,),
                      Spacer(),
                      Icon(Icons.search,color: Colors.grey,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 15,top: 10),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(title: 'Reminder'.tr(), titleColor: Colors.black, titleFontWeight: FontWeight.bold),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(title: 'CheckActive'.tr(), titleColor: Colors.black),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(title: 'readyMeeting.'.tr(), titleColor: Colors.black),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(title: 'NoAppointment'.tr(), titleColor: Colors.black),
                            TextWidget(title: 'day'.tr(), titleColor: Colors.black),
                          ],
                        ),
                        SizedBox(width: 50,),
                        ElevatedButton(onPressed: (){}, child: TextWidget(title: "CHEACKDATE".tr(),titleColor: Colors.white,),style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),)
                        /*CustomTextButton(title: "CHEAK DATE",

                        )*/
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // تغيير اتجاه التمرير إلى أفقي
                  itemCount: img.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width, // جعل عرض العنصر يمتد لعرض الشاشة
                      child: ListTile(
                        title: Image.asset(img[index], fit: BoxFit.cover),
                        onTap: () {
                          setState(() {
                            currentImagePath = img[index];
                          });
                          print('image $index');
                        },
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 7,),
              Row(

                children: [
                  TextWidget(title: "PopularMedicines".tr(),titleColor: Colors.black,
                      titleSize: 21,titleFontWeight: FontWeight.bold,),
                  Spacer(),
                   /*     ListTileWidget(
          onTap: () {

          },
          icon: Icons.star,
          trailingIcon: true,
          tralingColor: Colors.blue,
          arrowIcon: true,
          title: 'عنوان العنصر',
          textColor: Colors.red,
          iconColor: Colors.green,
          image: true,
          //imageUrl: 'assets/images/view.png',
        ),*/
                  InkWell(child: TextWidget(title: "SEEALL".tr(),titleColor: Colors.black,
                    titleSize: 15,titleFontWeight: FontWeight.bold,),
                  onTap: (){},),
                  SizedBox(width: 4,),
                  Icon(Icons.arrow_forward_ios_outlined,size: 17,),
        ],
              ),
              SizedBox(height: 7,),
              Container(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemCount: spice.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                       border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(
                        spice[index],
                        width: 70,
                        height: 70,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
      ),
    ),
        bottomNavigationBar: ButtonNavBar(initialIndex: 0)
    );
  }
}
