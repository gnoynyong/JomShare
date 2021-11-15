import 'package:flutter/material.dart';

class OfferPool extends StatefulWidget {
  const OfferPool({ Key? key }) : super(key: key);

  @override
  _OfferPoolState createState() => _OfferPoolState();
}

class _OfferPoolState extends State<OfferPool> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Offer Carpool"),
        ),
    );
  }
}