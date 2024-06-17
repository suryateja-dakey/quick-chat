import 'package:chater/screens/login_screen.dart';
import 'package:chater/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>  with SingleTickerProviderStateMixin {
  @override
    late  AnimationController controller;
    var c=0.0;
      void initState(){
        super.initState();
        controller =AnimationController(duration: Duration(seconds: 1), vsync: this,);
        controller.forward();
        Firebase.initializeApp();
        controller.addListener(() {
          setState(() {
            
          });
          c=controller.value;
          print(c);
        });
      }

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:Color.fromARGB(255, 0, 0, 0).withOpacity(c),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),

               AnimatedTextKit(
                   
                   animatedTexts: [
                     WavyAnimatedText(' Quick Chat',textStyle: TextStyle(
                       fontSize: 45,
                       color:Color.fromARGB(255, 253, 253, 253),
                     )),
                     //  WavyAnimatedText('N o r m a l'),
                     //  TypewriterAnimatedText('Normal'),
                     
                   ],
                 
                 )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Color.fromARGB(255, 82, 87, 90),
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                     Navigator.push(
              context,
               MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color:Color.fromARGB(255, 91, 47, 92),
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                     Navigator.push(
              context,
               MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  );
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}