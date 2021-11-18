import 'package:flutter/material.dart';

class SmallRoundButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color bckcolor,textColor;
  const SmallRoundButton({
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
      width: MediaQuery.of(context).size.width*0.45,
      child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
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
