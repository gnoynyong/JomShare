import 'package:flutter/material.dart';

class SmallRoundButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color bckcolor,textColor;
  final TextStyle btnstyle;
  const SmallRoundButton({
    Key? key,
     required this.text, 
     required this.press, 
     required this.bckcolor, 
     required this.textColor,
     required this.btnstyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width*0.3,
      child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child:
            TextButton(
              style: TextButton.styleFrom(
               primary: textColor,
               backgroundColor: bckcolor,
               padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10)
              ),
              onPressed:press,
              child:Text(
                text,
              style: btnstyle,
                )
     ),
     ),
    );
  }
}
