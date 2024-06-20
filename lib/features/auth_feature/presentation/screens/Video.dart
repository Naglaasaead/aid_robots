/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'call_page.dart';

class VideoScreen extends StatelessWidget {
  final TextEditingController callIdController = TextEditingController();

  VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/zoom.png",
            width: 150,
          ),
          const Text("Enter Call id to start the call", style: TextStyle(fontSize: 22)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: callIdController,
              decoration: InputDecoration(
                labelText: 'Call ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return CallPage(callID: callIdController.text); // Correctly pass the string value
                  }),
                );
              },
              child: Text('Start Call'),
            ),
          ),
        ],
      ),
    );
  }
}
*//*




import 'package:aid_robot/app/widgets/textform_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/Cubit/call_cubit.dart';
import '../../../../app/Cubit/call_state.dart';
import '../../../../app/widgets/button_call.dart';
import 'call_page.dart';


class HomeCallIDPage extends StatelessWidget {
  HomeCallIDPage({super.key});

  final TextEditingController callIDController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final HomeCallIDCubit cubit = BlocProvider.of<HomeCallIDCubit>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Join Video Call',
          */
/*  style: GoogleFonts.agbalumo()
                .copyWith(fontWeight: FontWeight.w400, fontSize: 25),*//*

          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation.json', height: 250, width: 250),
                const SizedBox(
                  height: 50,
                ),
                CustomTextFields(
                  labelText: 'Enter Name',
                  hintText: 'Enter your name',
                  controller: userNameController,
                  backgroundColor: Colors.white24,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFields(
                  labelText: 'Enter Call ID',
                  hintText: 'Enter the call ID to join',
                  controller: callIDController,
                  backgroundColor: Colors.white24,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                // Button
                BlocConsumer<HomeCallIDCubit, HomeCallIDState>(
                  listener: (BuildContext context, HomeCallIDState state) {
                    if (state is HomeCallIDSuccessState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoCallPage(
                            userName: state.userName,
                            callId: state.callId.toString(),
                          ),
                        ),
                      );
                    } else if (state is HomeCallIDErrorState) {
                      showCustomSnackBar(context, state.message);
                    }
                  },
                  builder: (BuildContext context, HomeCallIDState state) {
                    return CustomElevatedButton(
                      onPressed: () {
                        final String callID = callIDController.text.trim();
                        final String userName = userNameController.text.trim();
                        cubit.joinCall(userName, callID);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}*/



//agora
/*

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  bool _validateError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Agora Group Video Calling'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: NetworkImage(
                      'https://www.agora.io/en/wp-content/uploads/2019/07/agora-symbol-vertical.png'),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.17,
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Text(
                  'Agora Group Video Call Demo',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  child: TextFormField(
                    controller: myController,
                    decoration: InputDecoration(
                      labelText: 'Channel Name',
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'test',
                      hintStyle: TextStyle(color: Colors.black45),
                      errorText:
                      _validateError ? 'Channel name is mandatory' : null,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.25,
                  child: MaterialButton(
                    onPressed: onJoin,
                    height: 40,
                    color: Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Join',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }


  Future<void> onJoin() async {
    setState(() {
      myController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });

    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);

    Navigator.push(
        context,
        MaterialPageRoute(
       //   builder: (context) => CallPage(channelName: myController.text),
        ));
  }

}*/
