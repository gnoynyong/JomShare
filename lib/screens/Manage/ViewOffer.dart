// ignore_for_file: file_names, camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/Manage/Offer.dart';
import 'package:jomshare/screens/Manage/EditOffer.dart';
import 'package:jomshare/screens/Manage/OfferedBody.dart';
import 'package:jomshare/screens/Manage/manageHome.dart';
import 'package:jomshare/screens/home/home.dart';
import 'package:jomshare/screens/offerpool/AcceptPool.dart';
import 'package:jomshare/screens/welcome/components/body.dart';

import 'Offer.dart';

class viewoffer extends StatelessWidget {
  viewoffer({Key? key, required this.voffer}) : super(key: key);

  final Offer voffer;

  // Widget frequent()
  // {
  //   if (voffer.type=='One-Time'){return Text("");}
  //   else if (voffer.type=='Frequent'){return Container(
  //     child: Row(
  //       children: [
  //         Text("Frequent Day: ", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey),),
  //         Text(voffer.repeatedDay, style: TextStyle(fontSize: 17.5),),
  //       ],
  //     ),
  //   );}
  //   else {return Text("");}
  // }
  CollectionReference carpooldb =
      FirebaseFirestore.instance.collection('carpool');
  Future<void> deleteCarpool() {
    FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser!.uid).update({'Offered carpools':FieldValue.arrayRemove([voffer.offerpoolid])});
    return carpooldb.doc(voffer.offerpoolid).delete();
  }
  String convert(String x)
  {
    List day=['Mon','Tue','Wed','Thurs','Fri','Sat','Sun'];
    List <String> daylist=x.substring(1).split('/');
    print(daylist);
   String temp="";

    for (int z =0;z<daylist.length;z++)
    {
      for (int m=0;m<day.length;m++)
      {
        if (int.parse(daylist[z])==(m))
        {
          temp=temp+"-"+day[m];
        }
      }



    }
    temp=temp.substring(1);
    print (temp);
    return temp;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()
          {
            Navigator.popUntil(context, ModalRoute.withName('/home'));

          },
          icon: Icon(Icons.arrow_back),),
          title: const Text("View Detail Information"),
          backgroundColor: lightpp),
      body: SingleChildScrollView(
          // margin: const EdgeInsets.all(10.0),
          // padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   border: Border.all(
          //     color: Colors.black12,
          //     width: 1,
          //   ),
          // ),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0 ),
          //   color: Colors.blueGrey[800],
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text("Passenger :" ,style: TextStyle(fontSize: 17.5, color: Colors.white.withOpacity(0.85))),
          //       ListView.builder(
          //         shrinkWrap: true, //another solution is use expanded to warp all listview.builder but will use entire screen
          //         padding: const EdgeInsets.all(10),
          //         itemCount: voffer.pname.length,
          //         itemBuilder:(context,index)=>
          //         Container(
          //           margin: EdgeInsets.only(bottom: 15.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               CircleAvatar(
          //                 radius: 24,
          //                 backgroundImage: AssetImage(voffer.pimage[index]),
          //               ),
          //               SizedBox(width: 10,),
          //               Text(voffer.pname[index], style: TextStyle(fontSize: 17.5, color: Colors.white.withOpacity(0.85)) ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        "Carpool Type :",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        voffer.type+" carpool",
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),


                ],)
                ,
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Date Time :",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: voffer.type == "Frequent"
                          ? Text(
                              "Frequent Day: ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            )
                          : Container(),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        voffer.datetime,
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: voffer.type == "Frequent"
                          ? SizedBox(
                            width: 100,
                            child: Text(
                                convert(voffer.repeatedDay),
                                style: TextStyle(fontSize: 17.5),
                              ),
                          )
                          : Container(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                      "Starting Point:",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )
                    )

                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 260,
                      child:  Text(
                      voffer.start,
                      style: TextStyle(fontSize: 17.5),
                    )
                    )

                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 200,
                    child:Text(
                      "Destination:",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ))

                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 260,
                    child: Text(
                      voffer.destination,
                      style: TextStyle(fontSize: 17.5),
                    ))

                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Vehicle Type :",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Plate No :",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Price :",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        voffer.vehicletype,
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        voffer.plateNo,
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "RM " + voffer.price.toStringAsFixed(2),
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       flex: 1,
                //       child: Row(
                //         children: [
                //           Text("Contact: ", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey),),
                //           Text(voffer.contact, style: TextStyle(fontSize: 17.5),),
                //         ],
                //       )
                //     ),
                //     Expanded(
                //       flex: 1,
                //       child:
                //         voffer.type=="Frequent"
                //         ?
                //         Row(
                //           children: [
                //             Text("Frequent Day: ", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey),),
                //             Text(voffer.repeatedDay, style: TextStyle(fontSize: 17.5),),
                //           ],
                //         )
                //         :
                //         Container(),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shadowColor: MaterialStateProperty.all(Colors.grey),
                    overlayColor:
                        MaterialStateProperty.all(Colors.green[400]),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AcceptPool(accept: voffer)),
                    );
                  },
                  child: Wrap(
                    spacing: 10.0,
                    children: [
                      Icon(
                        Icons.people,
                        size: 20.0,
                      ),
                      Text(
                        "View request",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.grey),
                    overlayColor:
                        MaterialStateProperty.all(Colors.blue[400]),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => editoffer(eoffer: voffer)),
                    );
                  },
                  child: Wrap(
                    spacing: 10.0,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 20.0,
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shadowColor: MaterialStateProperty.all(Colors.grey),
                    overlayColor:
                        MaterialStateProperty.all(Colors.red[400]),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  onPressed: () {
                    deleteCarpool();
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Home()));
                  },
                  child: Wrap(
                    spacing: 10.0,
                    children: [
                      Icon(
                        Icons.delete,
                        size: 20.0,
                      ),
                      Text(
                        "Delete",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
