// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, use_build_context_synchronously

import 'package:chater/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final auth = FirebaseAuth.instance;
  var emails;
  var e_varf;
  var p_varf;
  var passwords;
  var eye=true;
  var s;
  bool n=true;
 
 // ;
 
  var ss = false;

   bool spins= false;
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
              Hero(
                tag: "logo",
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  emails = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 77, 34, 78), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color:Color.fromARGB(255, 77, 34, 78), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  
                  errorText: ss ? '' : null,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: eye,
                
                
                onChanged: (value) {
                  //Do something with the user input.
                  
                  passwords = value;
                },
                decoration: InputDecoration(
                  suffixIcon: n? GestureDetector(
                    child:  Icon(Icons.visibility, color: Color.fromARGB(255, 209, 171, 1),),
                              onTap: () {
                                setState(() {
                                  eye=!eye;
                                  n=false;

                                });},):GestureDetector(
                    child:  Icon(Icons.visibility_off, color: Color.fromARGB(255, 209, 171, 1),),
                              onTap: () {
                                setState(() {
                                  eye=!eye;
                                  n=true;

                                });},),
                  hintText: 'Enter your password.',
                   
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 77, 34, 78), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color:Color.fromARGB(255, 77, 34, 78), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  errorText: ss ? 'Invalid fields' : null,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color:Color.fromARGB(255, 77, 34, 78),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: Column(
                    children: [
                      MaterialButton(
                        onPressed: () async{
                          setState(() {
                            spins=true;
                          });
                        
                          try {
                            final user = await auth.signInWithEmailAndPassword(
                                email: emails, password: passwords);
      
                            if (user != null) {
                            //  print("sucess");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChatScreen()),
                              );
                            }
                            setState(() {
                              spins=false;
                            });
                          } catch (e) {
                            print(e);
                             setState(() {
                              spins=false;
                              ss =true;
                            });
                          }
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Log In',
                        ),
                      ),
                       MaterialButton(
                            onPressed: () async {
                              setState(() {
                                 Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WelcomeScreen()),
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
                          ),   ],
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
