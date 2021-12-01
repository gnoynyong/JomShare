// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, file_names, unused_local_variable, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/Manage/Offer.dart';
import 'package:jomshare/screens/welcome/components/background.dart';
import 'package:jomshare/screens/welcome/components/body.dart';

import 'OfferCard.dart';

class OfferedBody extends StatefulWidget {
  const OfferedBody({Key? key}) : super(key: key);

  @override
  _OfferedBodyState createState() => _OfferedBodyState();
}

class _OfferedBodyState extends State<OfferedBody> {
  List<dynamic> carpoolist = <dynamic>[];
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
        if (snapshot.hasData) {
          final cvalue = snapshot.data!.data()!["Offered carpools"];
          List<String> mycarpoolid = List.from(cvalue);
          print(mycarpoolid.length);
          CollectionReference carpool =
              FirebaseFirestore.instance.collection("carpool");
          // if (carpoolist.isNotEmpty) {
          //   carpoolist.clear();
          // }
          mycarpoolid.forEach((element) async {
            DocumentReference cdoc = carpool.doc(element);
            DocumentSnapshot cds = await cdoc.get();
            Offer offerpool = new Offer(
              datetime: cds.data()!["Date Time"],
              start: cds.data()!["Pickup address"],
              destination: cds.data()!["Drop address"],
              vehicletype: cds.data()!["Car type"],
              plateNo: cds.data()!["Plate no"],
              price: cds.data()!["Price"],
              type: cds.data()!["Pool type"],
              repeatedDay: cds.data()!["Repeated Day"],
              offerpoolid: element,
              requestid:List.from(cds.data()!["requestList"]),
            );
            carpoolist.add(offerpool);
            print("Carpool read");
          });
        }
        return Container(
            color: Colors.grey[100],
            child: Column(children: [
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: carpoolist.length,
                      itemBuilder: (context, index) => OfferCard(
                            offer: carpoolist[index],
                            press: () {},
                          ))),
            ]));
      },
    );
  }
}
