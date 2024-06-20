/*
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../Constant/constant.dart';
import '../../../../app/model/model chat.dart';

class Chat1 extends StatefulWidget {
  const Chat1({super.key});

  @override
  State<Chat1> createState() => _Chat1State();
}

class _Chat1State extends State<Chat1> {
  TextEditingController text = TextEditingController();
  String myname = "Chat_1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(child: Text("Chat 1")),
      ),
      body: Container(
        color: Colors.grey,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) => BubbleSpecialThree(
                  text: chat[index].text.toString(),
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
*/









/*


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _fireStore = FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  static const String ScreenRoute = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  String? messageText;
  TextEditingController messageTextControll = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          signedInUser = user;
        });
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

 */
/* void messageStream() async {
    await for (var snapshot in _fireStore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }*//*


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              "assets/images/whatsab.png",
              height: 25,
            ),
            SizedBox(width: 15),
            Text("MessageMe"),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: signedInUser == null
                  ? Center(child: CircularProgressIndicator())
                  : MessageStreamBuilder(),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: Colors.orange),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextControll,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        hintText: 'Write Your Message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextControll.clear();
                      _fireStore.collection('messages').add({
                        'text': messageText,
                        'sender': signedInUser.email,
                        'time':FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      "Send",
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messageWidgets = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final currentUser = signedInUser.email;
          final messageWidget = MessageLine(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messageWidgets.add(messageWidget);
        }
        return ListView(
          reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: messageWidgets,
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine(
      {super.key, required this.text, required this.sender, required this.isMe});
  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )
                : BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            elevation: 5,
            color: isMe ? Colors.blue[800] : Colors.black87,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '$text ',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/

/*


import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final _fireStore = FirebaseFirestore.instance;
late User signedInUser;
XFile? imageCamera;
ImagePicker? imagePickere;

class ChatScreen extends StatefulWidget {
  static const String ScreenRoute = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  File? file;
  String? messageText;
  TextEditingController messageTextControll = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getImage() async {
    imagePickere = ImagePicker();
    imageCamera = await imagePickere?.pickImage(source: ImageSource.camera);
    if (imageCamera != null) {
      file = File(imageCamera!.path);
      print("Image picker: $file");

      setState(() {});
    } else {
      print('No image selected.');
    }
  }

  String? imageUrl;

  uploadImage() async {
    if (file != null) {
      var imageName = basename(file!.path);
      var refStorage = FirebaseStorage.instance.ref(imageName);

      try {
        await refStorage.putFile(file!);
        imageUrl = await refStorage.getDownloadURL();
        print("Image URL: $imageUrl");
      } catch (e) {
        print("Error uploading file: $e");
      }
    }
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          signedInUser = user;
        });
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              "assets/images/whatsab.png",
              height: 25,
            ),
            SizedBox(width: 15),
            Text("MessageMe"),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) async {
              if (value == 'delete') {
                String documentId = '/messages/5WhRf1Be0XkrtpCsT0iU'; // Replace with actual document ID
                CollectionReference ref = FirebaseFirestore.instance.collection('messages');
                try {
                  await ref.doc(documentId).delete().then((value) => Navigator.pop(context));
                  print('Document successfully deleted');
                } catch (e) {
                  print('Error deleting document: $e');
                }
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: signedInUser == null
                  ? Center(child: CircularProgressIndicator())
                  : MessageStreamBuilder(),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: Colors.orange),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextControll,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        hintText: 'Write Your Message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          await uploadImage();
                          if (messageText != null || imageUrl != null) {
                            DocumentReference docRef = FirebaseFirestore.instance.collection('messages').doc();
                            String autoID = docRef.id;
                            _fireStore.collection('messages').add({
                              'uid': autoID,
                              'text': messageText ?? '',
                              'sender': signedInUser.email,
                              'time': FieldValue.serverTimestamp(),
                              'imageUrl': imageUrl,
                            });
                            messageTextControll.clear();
                            imageUrl = null;
                            file = null;
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.send,
                              color: Colors.blue[800],
                              size: 24.0,
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          messageTextControll.clear();
                          getImage();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.blue[800],
                              size: 24.0,
                            ),
                            if (file != null) ...[
                              SizedBox(width: 8),
                            ]
                          ],
                        ),
                      ),
                    ],
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

class MessageStreamBuilder extends StatelessWidget {
  MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').orderBy('time', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        List<MessageLine> messageWidgets = snapshot.data!.docs.map((DocumentSnapshot document) {
          final messageText = document.get('text') ?? 'No message';
          final messageSender = document.get('sender') ?? 'Anonymous';
          final messageImageUrl = document.get('imageUrl') as String?;
          final currentUser = signedInUser.email;

          final imageUrl = messageImageUrl ?? '';

          return MessageLine(
            sender: messageSender,
            text: messageText,
            imageUrl: imageUrl,
            isMe: currentUser == messageSender,
          );
        }).toList();

        return ListView(
          reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: messageWidgets,
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({
    Key? key,
    required this.text,
    required this.sender,
    required this.isMe,
    this.imageUrl,
  }) : super(key: key);

  final String text;
  final String sender;
  final bool isMe;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
          if (imageUrl != null && imageUrl!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.network(
                imageUrl!,
                width: 100,
                height: 100,
              ),
            ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )
                : BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            elevation: 5,
            color: isMe ? Colors.blue[800] : Colors.black87,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                text,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/


/*

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final _fireStore = FirebaseFirestore.instance;
late User signedInUser;
XFile? imageCamera;
ImagePicker? imagePicker;

class ChatScreen extends StatefulWidget {
  static const String ScreenRoute = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  File? file;
  String? messageText;
  TextEditingController messageTextControll = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getImage(ImageSource source) async {
    imagePicker = ImagePicker();
    imageCamera = await imagePicker?.pickImage(source: source);
    if (imageCamera != null) {
      file = File(imageCamera!.path);
      print("Image picker: $file");

      setState(() {});
      showImagePreviewBottomSheet(context as BuildContext);
    } else {
      print('No image selected.');
    }
  }

  Future<String?> uploadImage() async {
    if (file != null) {
      var imageName = basename(file!.path);
      var refStorage = FirebaseStorage.instance.ref(imageName);

      try {
        await refStorage.putFile(file!);
        String imageUrl = await refStorage.getDownloadURL();
        print("Image URL: $imageUrl");
        return imageUrl;
      } catch (e) {
        print("Error uploading file: $e");
      }
    }
    return null;
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          signedInUser = user;
        });
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendMessage({String? text, String? imageUrl}) async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('messages').doc();
    String autoID = docRef.id;

    _fireStore.collection('messages').add({
      'uid': autoID,
      'text': text ?? '',
      'sender': signedInUser.email,
      'time': FieldValue.serverTimestamp(),
      'imageUrl': imageUrl,
    });

    messageTextControll.clear();
    setState(() {
      messageText = null;
      file = null; // إعادة تعيين ملف الصورة بعد الإرسال
    });
  }

  void showImageSourceSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a picture'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showImagePreviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (file != null)
                Image.file(
                  file!,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String? uploadedImageUrl = await uploadImage();
                  if (uploadedImageUrl != null) {
                    await sendMessage(imageUrl: uploadedImageUrl);
                  }
                },
                child: Text('Upload Image'),
              ),
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
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              "assets/images/whatsab.png",
              height: 25,
            ),
            SizedBox(width: 15),
            Text("MessageMe"),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) async {
              if (value == 'delete') {
                String documentId = '/messages/5WhRf1Be0XkrtpCsT0iU'; // Replace with actual document ID
                CollectionReference ref = FirebaseFirestore.instance.collection('messages');
                try {
                  await ref.doc(documentId).delete().then((value) => Navigator.pop(context));
                  print('Document successfully deleted');
                } catch (e) {
                  print('Error deleting document: $e');
                }
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: signedInUser == null
                  ? Center(child: CircularProgressIndicator())
                  : MessageStreamBuilder(),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: Colors.orange),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextControll,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        hintText: 'Write Your Message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Only send the text if there's no image selected
                      if (file == null && messageText != null && messageText!.isNotEmpty) {
                        await sendMessage(text: messageText);
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.blue[800],
                      size: 24.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextControll.clear();
                      showImageSourceSelection(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.blue[800],
                      size: 24.0,
                    ),
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

class MessageStreamBuilder extends StatelessWidget {
  MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').orderBy('time', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        List<MessageLine> messageWidgets = snapshot.data!.docs.map((DocumentSnapshot document) {
          final messageText = document.get('text') ?? '';
          final messageSender = document.get('sender') ?? 'Anonymous';
          final messageImageUrl = document.get('imageUrl') as String?;
          final currentUser = signedInUser.email;

          final imageUrl = messageImageUrl ?? '';

          return MessageLine(
            sender: messageSender,
            text: messageText,
            imageUrl: imageUrl,
            isMe: currentUser == messageSender,
          );
        }).toList();

        return ListView(
          reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: messageWidgets,
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({
    Key? key,
    required this.text,
    required this.sender,
    required this.isMe,
    this.imageUrl,
  }) : super(key: key);

  final String text;
  final String sender;
  final bool isMe;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
          if (imageUrl != null && imageUrl!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.network(
                imageUrl!,
                width: 100,
                height: 100,
              ),
            ),
          if (text.isNotEmpty)
            Material(
              borderRadius: isMe
                  ? BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )
                  : BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              elevation: 5,
              color: isMe ? Colors.blue[800] : Colors.black87,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}*/




import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final _fireStore = FirebaseFirestore.instance;
late User signedInUser;
XFile? imageCamera;
ImagePicker? imagePicker;

class ChatScreen extends StatefulWidget {
  static const String ScreenRoute = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  File? file;
  String? messageText;
  TextEditingController messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getImage(ImageSource source) async {
    imagePicker = ImagePicker();
    imageCamera = await imagePicker?.pickImage(source: source);
    if (imageCamera != null) {
      file = File(imageCamera!.path);
      print("Image picker: $file");

      setState(() {});
      showImagePreviewBottomSheet(context as BuildContext);
    } else {
      print('No image selected.');
    }
  }

  Future<String?> uploadImage() async {
    if (file != null) {
      var imageName = basename(file!.path);
      var refStorage = FirebaseStorage.instance.ref().child(imageName);

      try {
        await refStorage.putFile(file!);
        String imageUrl = await refStorage.getDownloadURL();
        print("Image URL: $imageUrl");
        return imageUrl;
      } catch (e) {
        print("Error uploading file: $e");
      }
    }
    return null;
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          signedInUser = user;
        });
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendMessage({String? text, String? imageUrl}) async {
    DocumentReference docRef = _fireStore.collection('messages').doc();
    String autoID = docRef.id;

    // Construct the message map
    Map<String, dynamic> messageMap = {
      'uid': autoID,
      'sender': signedInUser.email,
      'time': FieldValue.serverTimestamp(),
    };

    if (imageUrl != null && imageUrl.isNotEmpty) {
      messageMap['imageUrl'] = imageUrl;
    }

    if (text != null && text.isNotEmpty && text != "No message") {
      messageMap['text'] = text;
    }

    try {
      if (messageMap.containsKey('text') || messageMap.containsKey('imageUrl')) {
        // Only send the message if either text or imageUrl is present
        await _fireStore.collection('messages').doc(autoID).set(messageMap);
        setState(() {
          messageText = null;
          file = null;
        });
        messageTextController.clear();
      } else {
        print('No valid message to send.');
      }
    } catch (e) {
      print("Error sending message: $e");
    }
  }



  void showImageSourceSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a picture'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showImagePreviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (file != null)
                Image.file(
                  file!,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String? uploadedImageUrl = await uploadImage();
                  if (uploadedImageUrl != null) {
                    await sendMessage(imageUrl: uploadedImageUrl);
                  }
                },
                child: Text('Upload Image'),
              ),
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
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              "assets/images/whatsab.png",
              height: 25,
            ),
            SizedBox(width: 15),
            Text("MessageMe"),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) async {
              if (value == 'delete') {
                String documentId = '/messages/5WhRf1Be0XkrtpCsT0iU'; // Replace with actual document ID
                CollectionReference ref = FirebaseFirestore.instance.collection('messages');
                try {
                  await ref.doc(documentId).delete().then((value) => Navigator.pop(context));
                  print('Document successfully deleted');
                } catch (e) {
                  print('Error deleting document: $e');
                }
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: signedInUser == null
                  ? Center(child: CircularProgressIndicator())
                  : MessageStreamBuilder(),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: Colors.orange),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        hintText: 'Write Your Message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Only send the text if there's no image selected
                      if (file == null && messageText != null && messageText!.isNotEmpty) {
                        await sendMessage(text: messageText);
                      } else if (file != null) {
                        // If there's an image selected, upload it
                        String? uploadedImageUrl = await uploadImage();
                        if (uploadedImageUrl != null) {
                          await sendMessage(imageUrl: uploadedImageUrl);
                        }
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.blue[800],
                      size: 24.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      showImageSourceSelection(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.blue[800],
                      size: 24.0,
                    ),
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

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').orderBy('time', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        List<MessageLine> messageWidgets = snapshot.data!.docs.map((DocumentSnapshot document) {
          final data = document.data() as Map<String, dynamic>;
          final messageText = data['text'] ?? 'No message';
          final messageSender = data['sender'] ?? 'Anonymous';
          final messageImageUrl = data['imageUrl'] as String?;
          final currentUser = signedInUser.email;

          final imageUrl = messageImageUrl ?? '';

          return MessageLine(
            sender: messageSender,
            text: messageText,
            imageUrl: imageUrl,
            isMe: currentUser == messageSender,
          );
        }).toList();

        return ListView(
          reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: messageWidgets,
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({
    Key? key,
    required this.text,
    required this.sender,
    required this.isMe,
    this.imageUrl,
  }) : super(key: key);

  final String text;
  final String sender;
  final bool isMe;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
    child:
    Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          sender,
          style: TextStyle(fontSize: 12, color: Colors.black45),
        ),
        if (imageUrl != null && imageUrl!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.network(
              imageUrl!,
              width: 100,
              height: 100,
            ),
          ),
        Material(
          borderRadius: isMe
              ? BorderRadius.only(
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
              : BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          elevation: 5,
          color: isMe ? Colors.blue[800] : Colors.black87,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ],
    ),
    );
  }
}

