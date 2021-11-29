// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/Manage/Offer.dart';
import 'package:jomshare/screens/welcome/components/background.dart';
import 'package:jomshare/screens/welcome/components/body.dart';

import 'OfferCard.dart';

class OfferedBody extends StatefulWidget {
  const OfferedBody({ Key? key }) : super(key: key);

  @override
  _OfferedBodyState createState() => _OfferedBodyState();
}

class _OfferedBodyState extends State<OfferedBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children:[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: offerdata.length,
              itemBuilder:(context,index)=>
              OfferCard(
                offer:offerdata[index],
                press: (){},
              )
            )
          ),
        ]
      )
    );
  }
}