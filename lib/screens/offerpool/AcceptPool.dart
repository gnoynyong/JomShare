// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/screens/Manage/Offer.dart';
import 'package:jomshare/screens/offerpool/Passenger.dart';
import 'package:jomshare/screens/offerpool/PassengerCard.dart';

class AcceptPool extends StatelessWidget {
  AcceptPool({Key? key, required this.accept}) : super(key: key);
  final Offer accept;
  List<dynamic> requestlist = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> currentpool = FirebaseFirestore.instance
        .collection("carpool")
        .doc(accept.offerpoolid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("Request"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: currentpool,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something wrong");
          }
          if (snapshot.hasData) {
            List<String> requestor = List.from(accept.requestid);
            requestor.forEach((element) async {
              CollectionReference userdb =
                  FirebaseFirestore.instance.collection("user");
              DocumentReference user = userdb.doc(element);
              DocumentSnapshot userdata = await user.get();
              Passenger obj = new Passenger(
                  name: userdata.data()!["name"],
                  image: "assets/image/cat1.jpg");
              requestlist.add(obj);
              print("list display");
              print(requestlist.length);
              print(requestlist[0].name);
            });
          }
          return ListView.builder(
            itemCount: requestlist.length,
            itemBuilder: (context, index) =>
                PassengerCard(psg: requestlist[index]),
          );
        },
      ),
    );

    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text("Request"),
    //     ),
    //     body: ListView.builder(
    //         itemCount: requestlist.length,
    //         itemBuilder: (context, index) =>
    //         PassengerCard(psg: requestlist[index])
    //         )
    //         );
  }
}
