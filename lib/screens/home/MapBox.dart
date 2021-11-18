import 'package:flutter/material.dart';

class MapBox extends StatelessWidget {
  const MapBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.6,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/map1.jpeg"),
          fit: BoxFit.fill)
        ),
    );
  }
}