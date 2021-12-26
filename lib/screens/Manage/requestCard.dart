// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jomshare/screens/Manage/ViewOffer.dart';
import 'package:jomshare/screens/Manage/ViewRequest.dart';
import 'package:jomshare/model/carpool.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RequestCard extends StatelessWidget {
  const RequestCard({
    Key? key,
    required this.request

  }) : super(key: key);

  final CarpoolObject request;
  Widget status()
  {
    String uid=FirebaseAuth.instance.currentUser!.uid;

      int userindex=0;
    bool checkexist=false;
    String status="";
    Color color=Colors.white;
    for (int m=0;m< request.requestid.length;m++)
    {
      if (uid==request.requestid[m])
      {
        userindex=m;
        checkexist=true;
      }

    }
    if (checkexist)

{
  status=request.requeststatus[userindex];
  if (request.poolstatus=="complete"&&status=="accepted")
  {
    color=Colors.green;

  }
  switch (status)
  {
    case "pending": color=Colors.blue;break;
    case "accepted": color=Colors.green;break;
    case "rejected": color=Colors.red;break;
  }
  return
                     Container(
                       padding: EdgeInsets.fromLTRB(20, 10, 20, 10),


                       decoration: BoxDecoration(
                         color:request.poolstatus=="complete"&&status=="accepted"?Colors.green:color ,
                         borderRadius: BorderRadius.circular(20)


                       ),
                       child: Text(

                         request.poolstatus=="complete"&&status=="accepted"?"completed".toUpperCase():status.toUpperCase(),
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),
                       ),
                     )





                ;
}
return Center();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                  request.datetime,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
            ),status()
               ],

             ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Icon(Icons.airport_shuttle),
                SizedBox(width: 15.0),
                SizedBox(width: 200,
                child:  Text(request.start),),
              ],
            ),
            Icon(Icons.more_vert),
            Row(
              children: [
                Icon(Icons.arrow_downward),
                SizedBox(width: 15.0),
                SizedBox(width: 200,
                child:  Text(request.destination),),

                Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.grey),
                    overlayColor: MaterialStateProperty.all(Colors.blue[400]),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:
                    (BuildContext context)=>ViewRequest(vrequest: request)));


                  },
                  child: Text("View")
                ),
              ],
            ),

           ],



        ),
      ),
    );
  }
}
