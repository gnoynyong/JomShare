
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/Manage/ViewHostPassenger.dart';
import 'package:jomshare/model/carpool.dart';
import 'package:jomshare/screens/Manage/requestBody.dart';
import 'package:jomshare/screens/Manage/manageHome.dart';
import 'package:jomshare/screens/home/home.dart';
import 'package:jomshare/screens/welcome/components/body.dart';


class ViewRequest extends StatefulWidget {
  ViewRequest({Key? key, required this.vrequest}) : super(key: key);

  final CarpoolObject vrequest;

  @override
  State<ViewRequest> createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  String uid=FirebaseAuth.instance.currentUser!.uid;
  CollectionReference carpooldb =
      FirebaseFirestore.instance.collection('carpool');
  Future <void> cancelCarpool() async {
    FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser!.uid).update(
      {
        'Requested carpools': FieldValue.arrayRemove([widget.vrequest.pooldocid])
      }
    );
   DocumentSnapshot x= await carpooldb.doc(widget.vrequest.pooldocid).get();
   List requestorID=x.data()!["requestList"];
   List requestorStatus=x.data()!["requestStatus"];
   int requestorIndex;


   for (int m=0;m<requestorID.length;m++)
   {
     if (FirebaseAuth.instance.currentUser!.uid==requestorID[m])
     {
       requestorIndex=m;
        requestorStatus[requestorIndex]="cancelled";
     }
   }
    carpooldb.doc(widget.vrequest.pooldocid).set(
      {
        "requestStatus": FieldValue.delete(),

      },SetOptions(merge: true)
    );
    carpooldb.doc(widget.vrequest.pooldocid).set(
      {
        "requestStatus": FieldValue.arrayUnion(requestorStatus),

      },SetOptions(merge: true)
    );



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

  Widget status()
  {

    int userindex=0;
    bool checkexist=false;
    String status="";
    Color color=Colors.white;
    for (int m=0;m< widget.vrequest.requestid.length;m++)
    {
      if (uid==widget.vrequest.requestid[m])
      {
        userindex=m;
        checkexist=true;
      }

    }
    if (checkexist)

{
  status=widget.vrequest.requeststatus[userindex];
  switch (status)
  {
    case "pending": color=Colors.blue;break;
    case "accepted": color=Colors.green;break;
    case "rejected": color=Colors.red;break;
  }
  return   Row(children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        "Status :",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                     Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(2, 10, 2, 10),


                        decoration: BoxDecoration(
                          color:color ,
                          borderRadius: BorderRadius.circular(20)


                        ),
                        child: Text(

                          status.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17.5,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),





                ],);
}
return Center();
  }
  String countPassenger ()
 {
   int numpassenger=0;

  List <String>requestUserId=[];



   for (int m=0;m<widget.vrequest.requestid.length;m++)
   {
     print("yes");
     if (widget.vrequest.requeststatus[m]=="accepted")
     {
       requestUserId.add(widget.vrequest.requestid[m]);
       print(widget.vrequest.requestid[m]);
       numpassenger++;
     }


   }
   return (numpassenger).toString()+"/"+widget.vrequest.seatno.toString();

 }
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
            child: Column(
              children: [
                status(),

                SizedBox(height: 20,),
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
                        widget.vrequest.type+" carpool",
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),


                ],)
                ,
                SizedBox(height: 20,)
                ,
                Row(children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        "No of passengers /seats offered :",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    Expanded(
                    flex: 1,
                    child: Text(
                      countPassenger(),
                      style: TextStyle(fontSize: 17.5),
                    ),
                  ),







                ],),
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
                      child: widget.vrequest.type == "Frequent"
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
                        widget.vrequest.datetime,
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: widget.vrequest.type == "Frequent"
                          ? SizedBox(
                            width: 100,
                            child: Text(
                                convert(widget.vrequest.repeatedDay),
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
                      widget.vrequest.start,
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
                      widget.vrequest.destination,
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
                        widget.vrequest.vehicletype,
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        widget.vrequest.plateNo,
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "RM " + widget.vrequest.price.toStringAsFixed(2),
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),

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
                    Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context)
                    =>ViewHostPassenger(request: widget.vrequest,))
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

                        "View host and \npassengers",
                        textAlign: TextAlign.center,
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
                    showDialog(context: context,
                    builder: (context)
                    {
                      return AlertDialog(
                        title: Text('Cancel Requested Carpool Confirmation'),
                        content: Text("Are you sure to cancel this requested carpool?"),
                        actions: [
                          TextButton(
              onPressed: () {
                cancelCarpool();
                Navigator.popUntil(context, ModalRoute.withName('/home'));

              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),

                        ],


                      );
                    });
                    },
                  child: Wrap(
                    spacing: 10.0,
                    children: [
                      Icon(
                        Icons.cancel,
                        size: 20.0,
                      ),
                      Text(
                        "Cancel request",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                )


              ],
            ),
          )

              ],

            ),
          ),

    );
  }
}