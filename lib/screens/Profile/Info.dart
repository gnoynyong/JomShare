import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';

class Info extends StatelessWidget {
 
  const Info({ 
    Key? key ,
    required this.name,
    required this.email,
    required this.image,
  }) : super(key: key);

  final String name, image;
  final String? email;
  @override
  Widget build(BuildContext context) {
   return SizedBox(
      height: 240, // 240
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: 150, //150
              color: darkblue,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10), //10
                  height: 140, //140
                  width: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 18, //8
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image),
                    ),
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 22, // 22
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5), //5
                Text(
                  email?? 'No email',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF8492A2),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}