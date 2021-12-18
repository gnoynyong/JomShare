
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/model/carpool.dart';
import 'package:jomshare/screens/Manage/requestCard.dart';

class requestBody extends StatefulWidget {
  const requestBody({ Key? key }) : super(key: key);

  @override
  _requestBodyState createState() => _requestBodyState();
}

class _requestBodyState extends State<requestBody> {
  bool _isloading=false;
  List <CarpoolObject> requestlist=[];
  final Stream<DocumentSnapshot> userdoc = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    if (_isloading)
    {
      return CircularProgressIndicator();
    }
    else
    {
       return StreamBuilder<DocumentSnapshot>(
      stream: userdoc,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot)
      {
         if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading..");
        }



        if (snapshot.hasData)
        {
          if (!snapshot.data!.data()!.containsKey("Requested carpools"))
          {

            return Center(child: Text('No carpool request has been made yet!',style: TextStyle(fontSize: 20),));

          }
          List temp=snapshot.data!["Requested carpools"];
          if (temp.length==0)
          {
            return Center(child: Text('No carpool request has been made yet.',style: TextStyle(fontSize: 20),));
          }

          List rlist=snapshot.data!['Requested carpools'];
          List <String> requestcarpoolID=[];
          for (int m=0;m<rlist.length;m++)
          {
            requestcarpoolID.add(rlist[m].toString());
          }
          CollectionReference carpool =
              FirebaseFirestore.instance.collection("carpool");
               print(requestcarpoolID);
              requestcarpoolID.forEach((element) async{
                 DocumentReference cdoc = carpool.doc(element);
                 DocumentSnapshot cds = await cdoc.get();
                  print(cds.exists);

                   if(cds.exists) {
                 CarpoolObject requestcarpool=new CarpoolObject(
                   datetime: cds.data()!["Date Time"],
                   start: cds.data()!["Pickup address"],
                   destination: cds.data()!["Drop address"],
                    vehicletype: cds.data()!["Car type"],
                     plateNo: cds.data()!["Plate no"],
                     price:  cds.data()!["Price"],
                     type: cds.data()!["Pool type"],
                     repeatedDay: cds.data()!["Repeated Day"],
                     pooldocid: element,
                     hostid: cds.data()!["Host ID"],
                     seatno: cds.data()!["Seat"],

                     );
                     print( cds.data()!["Date Time"]);
                     print(cds.data()!["Pickup address"]);
                     print(cds.data()!["Drop address"]);
                     requestcarpool.addRequestIDWithStatus(cds.data()!["requestList"],cds.data()!["requestStatus"] );

                      bool check=false;
            int listindex=0;
            print('test');
            for (int p=0;p<requestlist.length;p++)
            {
              check=false;
              if (requestlist[p].pooldocid==requestcarpool.pooldocid)
              {
                check=true;
                listindex=p;
                break;

              }

            }
            if (check)
            {
              requestlist.removeAt(listindex);
              requestlist.insert(listindex, requestcarpool);
            }
            else
            {
              requestlist.add(requestcarpool);

            }
              }

              }

              );
              print('No');







          }
          return Container(
            color: Colors.grey[100],
            child: Column(children: [
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: requestlist.length,
                      itemBuilder: (context, index) {
                        print("try");

                        return RequestCard(
                            request: requestlist[index],

                          );
                      } )),
            ]));


        }



    );
    }

  }
}