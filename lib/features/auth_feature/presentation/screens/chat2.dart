import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Constant/constant.dart';
import '../../../../app/model/model chat.dart';

class Chat2 extends StatefulWidget {
  const Chat2({super.key});

  @override
  State<Chat2> createState() => _Chat2State();
}

class _Chat2State extends State<Chat2> {
  TextEditingController text = TextEditingController();
  String myname = "Chat_2";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(child: Text("Chat 2")),
      ),
      body: Container(
        color: Colors.grey,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) => BubbleSpecialThree(
                  text: chat[index].text,
                  color: chat[index].senderName == myname ? Colors.green : Colors.blue,
                  tail: true,
                  textStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  isSender: chat[index].senderName == myname ? true : false,
                ),
                itemCount: chat.length,
              ),
            ),
            Container(
              color: Colors.black,
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: text,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        chat.add(ModelChat(text.text, myname));
                        text.clear();
                      });
                    },
                    icon: Icon(Icons.send, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
