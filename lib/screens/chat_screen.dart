// ignore_for_file: prefer_typing_uninitialized_variables, annotate_overrides, library_private_types_in_public_api, use_key_in_widget_constructors, avoid_print, prefer_const_constructors

import 'package:chater/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chater/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'registration_screen.dart';

var signedUser;
var messageText;
final auth = FirebaseAuth.instance;
final cloud = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void initState() {
    super.initState();
    Cuser();
  }

  void Cuser() {
    try {
      var user = auth.currentUser;
      if (user != null) {
        signedUser = user.email;
        print(signedUser);
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in cloud.collection('messages').snapshots()) {
      for (var messages in snapshot.docs) {
        print(messages.data());
      }
    }
  }

  TextEditingController s = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messagesStream();
                auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Color.fromARGB(255, 77, 34, 78),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: cloud.collection("messages").orderBy('time',descending: false).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 91, 47, 92),
                      ),
                    );
                  }
                  final messages = snapshot.data!.docs.reversed;
                  List<MessageBubble> messageBubbles = [];
                  for (var message in messages) {
                    // final messageData=message.data();
                    final messageText = message.get('text');
                    final messageSender = message.get('sender');
                    final messageTime=message.get('time') ;
                    // final presentUser = signedUser.email;
                    final messageBubble = MessageBubble(
                      sender: messageSender,
                      text: messageText,
                      isMe: messageSender == signedUser,
                      time:messageTime,
                    );
                    messageBubbles.add(messageBubble);
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      children: messageBubbles,
                    ),
                  );
                }),
            Container(
             // color: Colors.white,
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: s,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                        setState(() {
                          value = "";
                        });
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      cloud.collection('messages').add({
                        'text': messageText,
                        'sender': signedUser,
                        'time':FieldValue.serverTimestamp()
                      });
                      s.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
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

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isMe, required this.time});
  final String sender;
  final String text;
  bool isMe;
   var time;
  // const MessageBubble ({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
              borderRadius:isMe? BorderRadius.only(
                  topLeft: Radius.circular(21),
                  topRight: Radius.circular(21),
                  bottomLeft: Radius.circular(21)):BorderRadius.only(
                  topLeft: Radius.circular(21),
                  topRight: Radius.circular(21),
                  bottomRight: Radius.circular(21)),

              //BorderRadiusDirectional.circular(21.0),
              // BorderRadius.circular(10.0),
              elevation: 5,
              color: isMe
                  ? Color.fromARGB(255, 91, 47, 92)
                  : Color.fromARGB(255, 82, 87, 90),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                child: Text(
                  '$text ',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              )),
          Text(
            '--$sender',
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
