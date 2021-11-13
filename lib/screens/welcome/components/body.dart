import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jomshare/components/roundbutton.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/welcome/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Background(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
        "WELCOME TO JOMSHARE",
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
        ),
        Image.asset(
          "assets/image/mainwelcome.jpg",
          height:size.height*0.45,
          ),
        RoundButton(
          text: "LOGIN",
          press: () {},
          textColor: Colors.white,
          bckcolor: primaryColor,
        ) ,
        RoundButton(
          text: "SIGN UP",
          press: (){},
          textColor: Colors.black,
          bckcolor: lightpp,
        )      
        ],
    ),
    );
  }
}


