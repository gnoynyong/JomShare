import 'package:flutter/material.dart';
import 'package:jomshare/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jomshare/screens/Profile/ViewUserProfile.dart';

class PassengerCard extends StatefulWidget {
  final UserData psg;
  final AsyncSnapshot<DocumentSnapshot> currentpool;

   PassengerCard({
    required this.psg,
     required this.currentpool
     }) ;


  @override
  State<PassengerCard> createState() => _PassengerCardState();
}

class _PassengerCardState extends State<PassengerCard> {

  @override

  Widget build(BuildContext context) {

      String poolid=widget.currentpool.data!.id;
      List requestorList=List.from(widget.currentpool.data!.data()!["requestList"]);
     List requestorStatus=List.from(widget.currentpool.data!.data()!["requestStatus"]);
  DocumentReference doc=FirebaseFirestore.instance.collection("carpool").doc(poolid);

  void acceptRequest()
  {
     int index=0;
    bool found=false;
    for (int x=0;x<requestorList.length;x++)
    {
      if(widget.psg.uid==requestorList[x].toString())
      {
        index=x;
        found=true;
      }
    }
    if(found)
    {
      requestorStatus[index]="accepted";
      doc.update(
        {
          "requestStatus": requestorStatus,

        }
      );
    }
  }
  void rejectRequest()
  {
 int index=0;
    bool found=false;
    for (int x=0;x<requestorList.length;x++)
    {
      if(widget.psg.uid==requestorList[x].toString())
      {
        index=x;
        found=true;
      }
    }
    if(found)
    {
      requestorStatus[index]="rejected";
      doc.update(
        {
          "requestStatus": requestorStatus,

        }
      );
    }
  }


    print(widget.psg.imageurl);
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
        child: Row(
          children: [

            TextButton(
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context)
                =>ViewUserProfile(user: widget.psg)));
              },
               child: CircleAvatar(
              radius: 20,
               backgroundImage: NetworkImage(widget.psg.imageurl),
            ),),
            SizedBox(
              width: 8.0,
            ),
            SizedBox(
              width: 80,
              child:  Text(widget.psg.name),
            )
           ,

           Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child:  Row(
                children: [

                  TextButton(
                    child: Text("Accept"),
                    style: TextButton.styleFrom(primary: Colors.white,backgroundColor: Colors.blue[300],),
                    onPressed: (){
                      acceptRequest();





                    },
                    ),
                  SizedBox(width: 8.0,),
                  TextButton(
                    child:Text("Reject"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red
                    ),
                    onPressed: (){
                      rejectRequest();




                    },
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