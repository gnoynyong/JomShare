import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jomshare/components/smallroundbutton.dart';
import 'package:jomshare/constants.dart';

class Pool extends StatefulWidget {
  const Pool({ Key? key }) : super(key: key);

  @override
  _PoolState createState() => _PoolState();
}

class _PoolState extends State<Pool> {
  List<bool> _selections = [false,true];
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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.45,
              decoration:BoxDecoration(
                borderRadius:BorderRadius.only(topLeft: Radius.circular(24),topRight:Radius.circular(24)),
                color: darkblue,
                ) ,
                child:
                Container(
                   margin:EdgeInsets.fromLTRB(20, 10, 20, 240),
                   child:
                    ToggleButtons(
                  children: <Widget>[
                   Container(
                    
                     width: MediaQuery.of(context).size.width*0.44,
                     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.car_rental,size:16.0,color: Colors.white,),SizedBox(width: 4.0) ,Text("Find Pool",style: TextStyle(color: Colors.white),)],),
                            
                   ),
                    Container(  
                      width: MediaQuery.of(context).size.width*0.44,
                     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.people,size:16.0,color: Colors.white,),SizedBox(width: 4.0) ,Text("Offer Pool",style: TextStyle(color: Colors.white),)],),
                   ),
                  ], 
                  borderRadius: BorderRadius.circular(40),
                  renderBorder: false,
                  color: Colors.white,
                  fillColor: Colors.white38,
                  isSelected: _selections,
                  onPressed: (index){
                    setState(() {
                      for(int i=0;i<_selections.length;i++){
                        if(i==index){
                          _selections[i]=true;
                        }
                        else{
                          _selections[i]=false;
                        }
                      }
                    });
                  },
                  )
                ),
            ),
              Container(
                margin: EdgeInsets.only(top: 100.0),
                height: MediaQuery.of(context).size.height*0.35,
                decoration:BoxDecoration(
                borderRadius:BorderRadius.only(topLeft: Radius.circular(24),topRight:Radius.circular(24)),
                color: Colors.white,
                ),
            )
              ],
              )
           
          ),
        ],
      )
   
    );
  }
}