import 'package:flutter/material.dart';

class ViewPool extends StatefulWidget {
  const ViewPool({ Key? key }) : super(key: key);

  @override
  _ViewPoolState createState() => _ViewPoolState();
}

class _ViewPoolState extends State<ViewPool> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Carpool"),),
      body:Column(
         children: [
           Container(
             child: Column(
               children: [
                 Text("UTM, Skudai Johor"),
                 Text("24 November 2021"),
                 Text("08:00AM")                 
               ],
             ),
           ),
           Expanded(
             child: Column(
               children: [
                 
               ],
             ),
           ),
         ],
        )
    );
  }
}