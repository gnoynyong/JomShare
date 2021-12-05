// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, file_names, unused_local_variable, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';

import 'package:jomshare/model/carpool.dart';
import 'package:jomshare/screens/welcome/components/background.dart';
import 'package:jomshare/screens/welcome/components/body.dart';

import 'OfferCard.dart';

class OfferedBody extends StatefulWidget {
  const OfferedBody({Key? key}) : super(key: key);

  @override
  _OfferedBodyState createState() => _OfferedBodyState();
}

class _OfferedBodyState extends State<OfferedBody> {
  bool _isloading=false;
  List<CarpoolObject> carpoolist = <CarpoolObject>[];
  final Stream<DocumentSnapshot> userdoc = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();


//   @override
// void initState() {
//   super.initState();

// }

  @override
  Widget build(BuildContext context) {

    print(FirebaseAuth.instance.currentUser!.uid);
    return StreamBuilder<DocumentSnapshot>(
      stream: userdoc,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading..");
        }
         if (!snapshot.data!.data()!.containsKey("Offered carpools"))
          {

            return Center(child: Text('No carpool has been offered yet!',style: TextStyle(fontSize: 20),));

          }
        List temp=snapshot.data!["Offered carpools"];
        if (temp.length==0)
        {
          return Center(child: Text('No carpool has been offered yet.',style: TextStyle(fontSize: 20),));
        }
        if(snapshot.hasData) {
          List cvalue = [];
          cvalue.clear();
          cvalue=snapshot.data!.data()!["Offered carpools"];
          print(cvalue);
          List<String> mycarpoolid = [];
          mycarpoolid.clear();

          for (int m=0;m<cvalue.length;m++)
          {
            mycarpoolid.add(cvalue[m].toString());
          }
          print(mycarpoolid);
          CollectionReference carpool =
              FirebaseFirestore.instance.collection("carpool");

          int dex=0;



          mycarpoolid.forEach((element) async {
            dex++;
            DocumentReference cdoc = carpool.doc(element);
            print(cdoc.id);
            DocumentSnapshot cds = await cdoc.get();
            List temp=[];
            print('start');
            print(element);
            print(cds.data()!["Date Time"]);
            print(cds.data()!["Pickup address"]);
            print(cds.data()!["Drop address"]);
             print(cds.data()!["Car type"]);
             print(cds.data()!["Plate no"]);
             print(cds.data()!["Price"]);
             print(cds.data()!["Pool type"]);
             print(cds.data()!["Repeated Day"]);

            CarpoolObject offerpool = new CarpoolObject(
              datetime: cds.data()!["Date Time"],
              start: cds.data()!["Pickup address"],
              destination: cds.data()!["Drop address"],
              vehicletype: cds.data()!["Car type"],
              plateNo: cds.data()!["Plate no"],
              price: cds.data()!["Price"],
              type: cds.data()!["Pool type"],
              repeatedDay: cds.data()!["Repeated Day"],
              pooldocid: element,
              seatno: cds.data()!["Seat"],
              hostid:  cds.data()!["Host ID"]

            );
            if (cds.data()!["requestList"]!=null)
            {
              offerpool.addRequestIDWithStatus(cds.data()!["requestList"],cds.data()!["requestStatus"]);
              print("RequestID: ${offerpool.requestid}");
            }

            print(!carpoolist.contains(offerpool));
            print(carpoolist);
            bool check=false;
            int listindex=0;
            for (int p=0;p<carpoolist.length;p++)
            {
              check=false;
              if (carpoolist[p].pooldocid==offerpool.pooldocid)
              {
                check=true;
                listindex=p;
                break;

              }
            }
            if(check)
            {
              print('exist');
              print(listindex);
              print(carpoolist[listindex]);
              carpoolist.removeAt(listindex);
              carpoolist.insert(listindex, offerpool);
              print(carpoolist[listindex]);
            }
            else
            {
              carpoolist.add(offerpool);
            }


            print("Carpool read");
            print("size:"+carpoolist.length.toString());

          });
        }

        return Container(
            color: Colors.grey[100],
            child: Column(children: [
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: carpoolist.length,
                      itemBuilder: (context, index) {

                        return OfferCard(
                            offer: carpoolist[index],
                            press: () {},
                          );
                      } )),
            ]));
      },
    );
  }
}
