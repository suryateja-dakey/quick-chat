import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color:Color.fromARGB(255, 137, 94, 138),
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
  fillColor: Colors.orangeAccent,
  
);

const kMessageContainerDecoration = BoxDecoration(
  //borderRadius: BorderRadius.only( topLeft: Radius.circular(21),topRight: Radius.circular(21),bottomLeft: Radius.circular(21),bottomRight: Radius.circular(21)),
border: Border(top: BorderSide(color: Color.fromARGB(255, 135, 83, 136), width: 2.0), ),
  //borderRadius:
  //color: Color.fromARGB(255, 168, 139, 34)
);
