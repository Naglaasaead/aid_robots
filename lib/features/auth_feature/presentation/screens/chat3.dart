

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
Future<void> urlLauncher(String name) async {
  String urlString = '';
  if (name == "phone") {
    urlString = "tel:+201550344738";
  } else if (name == "facebook") {
    urlString = "https://www.facebook.com/profile";
  }
  else if (name == "whatsApp") {
    urlString =  "https://wa.me/201550344738";
  }

  Uri url = Uri.parse(urlString);

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw Exception('Could not launch $urlString');
  }
}
final _fireStore = FirebaseFirestore.instance;
late User signedInUser;
XFile? imageCamera;
ImagePicker? imagePicker;

class ChatScreen2 extends StatefulWidget {
  static const String ScreenRoute = 'chat_screen';
  const ChatScreen2({Key? key}) : super(key: key);

  @override
  State<ChatScreen2> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen2> {
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
    DocumentReference docRef = _fireStore.collection('Message2').doc();
    String autoID = docRef.id;

    // Construct the message map
    Map<String, dynamic> messageMap = {
      'uid': autoID,
      'sender': signedInUser.email,
      'time': FieldValue.serverTimestamp(),
      "imageUrl":null,
      "text":null,
    };

    // Include image URL if present
    if (imageUrl != null && imageUrl.isNotEmpty) {
      messageMap['imageUrl'] = imageUrl;
      setState(() {

      });
    }

    // Include text if present and not "No message"
    if (text != null && text.isNotEmpty) {
      messageMap['text'] = text;
      setState(() {

      });
    }

    try {
      // Only send the message if either text or imageUrl is present
      //if (messageMap.containsKey('text') || messageMap.containsKey('imageUrl')) {
      await _fireStore.collection('Message2').doc(autoID).set(messageMap);
      setState(() {
        messageText = null;
        file = null;
      });
      messageTextController.clear();
      // } else {
      //   print('No valid message to send.');
      // }
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
            InkWell(
              onTap: () {
                // urlLauncher('phone');
              },
              child: InkWell(
                onTap: () {
                  urlLauncher('phone');
                },
                child: Container(
                  width: 30,
                  height: 30,
                  padding: EdgeInsets.all(4.0),
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //color: Colors.green,
                  ),
                  child: Icon(Icons.phone, color: Colors.black87),
                ),
              ),
            ),
           /* SizedBox(width: 15),
            Image.asset(
              "assets/images/whatsab.png",
              height: 25,
            ),*/
            SizedBox(width: 15),
            Text("MessageMe",style: TextStyle(color: Colors.black87),),
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
      stream: _fireStore.collection('Message2').orderBy('time', descending: true).snapshots(),
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
          final messageText = data['text'] ?? "";
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
          LayoutBuilder(
            builder: (context, constraints) {
              // Calculate bubble width and height based on text size
              TextPainter textPainter = TextPainter(
                text: TextSpan(
                  text: text,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(maxWidth: constraints.maxWidth);

              double bubbleWidth = textPainter.width + 30; // Add padding or margins as needed
              double bubbleHeight = textPainter.height + 20; // Add padding or margins as needed

              return
                text!=""?
                ChatBubble(
                  clipper: isMe ? ChatBubbleClipper3(type: BubbleType.sendBubble) :
                  ChatBubbleClipper3(type: BubbleType.receiverBubble),
                  alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10),
                  backGroundColor: isMe ? Colors.blue[800]! : Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                )
                    :
                SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
