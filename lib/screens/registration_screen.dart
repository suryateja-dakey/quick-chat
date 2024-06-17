// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, unused_import, unnecessary_string_interpolations

import 'package:chater/screens/chat_screen.dart';
import 'package:chater/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:chater/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final auth = FirebaseAuth.instance;
  var email;
  var password;
  var newUser;
  var eye = true;
  var valid;
  var ss = false;
  String error1 = '';
  String error3 = '';
  String error4 = '';
  String error5 = '';
  bool n = true;
  bool m=false;

  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  bool spins = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: ModalProgressHUD(
        inAsyncCall: spins,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  // errorBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //       color: Color.fromARGB(255, 77, 34, 78), width: 1.0),
                  //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  // ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 77, 34, 78), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 77, 34, 78), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  errorText:m?" ":null
                  // errorText: error!=null||error.isNotEmpty?error:null,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: eye,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.

                  password = value;
                },
                decoration: InputDecoration(
                  suffixIcon: n
                      ? GestureDetector(
                          child: Icon(
                            Icons.visibility,
                            color: Color.fromARGB(255, 255, 224, 47),
                          ),
                          onTap: () {
                            setState(() {
                              eye = !eye;
                              n = false;
                            });
                          },
                        )
                      : GestureDetector(
                          child: Icon(
                            Icons.visibility_off,
                            color: Color.fromARGB(255, 255, 224, 47),
                          ),
                          onTap: () {
                            setState(() {
                              eye = !eye;
                              n = true;
                            });
                          },
                        ),
                  hintText: 'Enter your password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 77, 34, 78), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 77, 34, 78), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                   errorText: m ? ' ' : null,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Color.fromARGB(255, 77, 34, 78),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: Column(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          if (email != null && password != null) {
                            //print(email+"   $password");

                            try {
                              newUser =
                                  await auth.createUserWithEmailAndPassword(
                                      email: email, password: password);

                              if (newUser != null) {
                                setState(() {
                                  spins = true;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen()),
                                );

                                setState(() {
                                  spins = false;
                                });
                              }
                            } catch (e) {
                              print(e);

                              print('----error---');
                              print(e.toString().substring(15, 35));
                              print(e.toString().substring(15, 28));
                              print(e.toString());
                              error1 = e.toString().substring(15, 35);
                              error3 = e.toString().substring(15, 28);
                              error4 = e.toString().substring(15, 28);

                              final snackBar = SnackBar(
                                backgroundColor:
                                   Color.fromARGB(50, 77, 34, 78),
                                duration: const Duration(seconds: 15),
                                action: SnackBarAction(
                                  label: 'Dismiss',
                                  onPressed: () {
                                    // Code to execute.
                                  },
                                ),
                                content: Text(
                                  error1 == "email-already-in-use"
                                      ? 'Email already exists 📚'
                                      : error3 == "invalid-email"
                                          ? "Invalid email 🚫"
                                          : error4 == "weak-password"
                                              ? "Weak Password 🔓"
                                              : "Please fill 📝",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 22),
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              setState(() {
                                // error=e.toString().substring(15,35);
                                spins = false;
                                ss = true;
                                m=true;
                              });
                              //  PopupMenuButton(itemBuilder: valid);
                            }
                          }
                          //error=e.toString().substring(15,35);
                          print(newUser);
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()),
                            );
                          });

                          //Implement login functionality.
                        },
                        minWidth: 200.0,
                        height: 55.0,
                        child: Text(
                          'Back to Home',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
