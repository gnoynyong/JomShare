import 'package:flutter/material.dart';

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
        "WELCOME TO ",
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),
        ),
        Image.asset(
          "assets/image/default.png",
          height:size.height*0.4,
          ),
        RoundButton(
          text: "LOGIN",
          press: () {
            Navigator.pushNamed(context, '/login');
          },
          textColor: Colors.white,
          bckcolor: background,
        ) ,
        RoundButton(
          text: "SIGN UP",
          press: (){
          Navigator.pushNamed(context, '/register');
          },
          textColor: Colors.black,
          bckcolor: lightpp,
        )
        ],
    ),
    );
  }
}
