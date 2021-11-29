import 'package:flutter/material.dart';
import 'package:jomshare/screens/offerpool/Passenger.dart';
import 'package:jomshare/screens/offerpool/PassengerCard.dart';
import 'PassengerCard.dart';

class AcceptPool extends StatefulWidget {
  const AcceptPool({ Key? key }) : super(key: key);

  @override
  _AcceptPoolState createState() => _AcceptPoolState();
}

class _AcceptPoolState extends State<AcceptPool> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Passenger"),),
      body: Column(
        children: [
          Expanded(
            child:ListView.builder(
              itemCount:PassengerData.length,
              itemBuilder:(context,index) =>
                PassengerCard(psg: PassengerData[index])
              )
            )
        ],
      ),
    );
  }
}