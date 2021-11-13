import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color bckcolor,textColor;
  const RoundButton({
    Key? key,
     required this.text, 
     required this.press, 
     required this.bckcolor, 
     required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width*0.7,
      child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child:
            TextButton(
              style: TextButton.styleFrom(
               primary: textColor,
               backgroundColor: bckcolor,
               padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40)
              ),
              onPressed:press,
              child:Text(
                text,
                )
     ),
     ),
    );
  }
}
