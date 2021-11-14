import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';

class bodyRequest extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context,int index)
      {

        return Card(
          child:Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/image/avatar.jfif'),
                radius: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('James Bond',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                        SizedBox(width: 10,),
                        Text('5.0'),
                        Icon(Icons.star,color: Colors.red,),
                        SizedBox(width: 10,),
                        ElevatedButton(onPressed: (){},

                        child: Text('Pending')
                        )





                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.fmd_good_outlined),
                        Text('Starting Point',style: TextStyle(fontSize: 15,color: Colors.grey)),
                        SizedBox(width: 10,),

                      ],
                    ),
                    SizedBox(height: 5,),

                    Text('UTM Johor,Skudai',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
                    ,
                      SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.fmd_good_outlined),
                        Text('Destination',style: TextStyle(fontSize: 15,color: Colors.grey)),


                      ],
                    ),
                    SizedBox(height: 5,),

                    Text('Senai Airport',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.fmd_good_outlined),
                        Text('Pick-Up Location',style: TextStyle(fontSize: 15,color: Colors.grey)),


                      ],
                    ),
                    SizedBox(height: 5,),

                    Text('UTM Main Entrance Gate',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.calendar_today),
                        Text('Pick-Up Date & Time',style: TextStyle(fontSize: 15,color: Colors.grey)),
                        SizedBox(width: 10,),

                      ],),
                      SizedBox(height: 5,),

                    Text('20/11/2021 5.00 P.M.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                     SizedBox(height: 5,),
                      Row(
                      children: [
                        Icon(Icons.local_taxi),
                        Text('Vehicle type\n&Plate No:',style: TextStyle(fontSize: 15,color: Colors.grey)),
                        SizedBox(width: 10,),
                        Text('SUV ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black)),
                          Text('JB1009 ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red))
                      ],),




                  ],
                ),
              )
            ],
          )

        );
      },
    );
  }
}