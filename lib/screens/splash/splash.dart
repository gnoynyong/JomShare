import 'dart:async';
import 'package:flutter/material.dart';

import  'package:jomshare/screens/welcome/welcome_screen.dart';
class splash extends StatefulWidget {


  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
          ()=>Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) =>WelcomeScreen()

                                                         )
                                       )
         );
  }
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

        decoration: BoxDecoration(
          color: Color.fromRGBO(210, 234, 245, 2),
          image:DecorationImage(image: AssetImage('assets/image/default.png'
          ,),
          )
        ),

      ),
    );
  }
}