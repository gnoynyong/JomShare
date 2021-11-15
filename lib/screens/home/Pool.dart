import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';

class Pool extends StatefulWidget {
  const Pool({ Key? key }) : super(key: key);

  @override
  _PoolState createState() => _PoolState();
}

class _PoolState extends State<Pool> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:<Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/map1.jpeg"),
                fit: BoxFit.fill)

              ),
          ),
          Flexible(
            // height: MediaQuery.of(context).size.height*0.42,
            // width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(borderRadius:BorderRadius.only(topLeft: Radius.circular(24),topRight:Radius.circular(24)
            //  ),
            //  color: Colors.green
            //  ),
            fit: FlexFit.tight,
            child: 
            Stack(
              children:[
              Container(
              decoration:BoxDecoration(
                borderRadius:BorderRadius.only(topLeft: Radius.circular(24),topRight:Radius.circular(24)),
                color: darkblue,
                ) , 
            ),
              Container(
                margin: EdgeInsets.only(top: 85.0),
                height: MediaQuery.of(context).size.height*0.35,
                decoration:BoxDecoration(
                borderRadius:BorderRadius.only(topLeft: Radius.circular(24),topRight:Radius.circular(24)),
                color: Colors.white,
                ) , 
            )
              ],
              )
           
          ),
        ],
      )
   
    );
  }
}