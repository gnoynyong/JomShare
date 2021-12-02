// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/screens/Manage/Offer.dart';
import 'package:jomshare/screens/offerpool/Passenger.dart';
import 'package:jomshare/screens/offerpool/PassengerCard.dart';

class AcceptPool extends StatefulWidget {
  AcceptPool({Key? key, required this.accept}) : super(key: key);
  final Offer accept;

  @override
  State<AcceptPool> createState() => _AcceptPoolState();
}

class _AcceptPoolState extends State<AcceptPool> {
  List<dynamic> requestlist = <dynamic>[];

  bool _isloading=false;

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> currentpool = FirebaseFirestore.instance
        .collection("carpool")
        .doc(widget.accept.offerpoolid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("Request"),
        actions: [
          IconButton(onPressed: (){
              setState(() {

              });
          },
          icon:Icon(Icons.cached_rounded))
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: currentpool,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
          if (snapshot.hasError) {
            return Text("Something wrong");
          }
          if (snapshot.hasData) {
            print("YEs");
             List<String> requestor = [];
             requestor.clear();
             print(widget.accept.requestid);
              for (int m=0;m<widget.accept.requestid.length;m++)
              {
                requestor.add(widget.accept.requestid[m].toString());
                print(m.toString()+":"+widget.accept.requestid[m].toString());
                print("Requestor:${requestor}");
              }
              if (requestor.isNotEmpty)
              {
                print ('not empty');
                 requestor.forEach((element) async {
              CollectionReference userdb =
                  FirebaseFirestore.instance.collection("user");
              DocumentReference user = userdb.doc(element);
              DocumentSnapshot userdata = await user.get();
              Passenger obj = new Passenger(
                  name: userdata.data()!["name"],
                  image: "assets/image/cat1.jpg");
                   bool check=false;
            for (int p=0;p<requestor.length;p++)
            {
              check=false;
              if (requestlist.length!=0)
              {
                check=true;
                break;

              }
            }
              !check?requestlist.add(obj):print('exist');
              print("list display");
              print(requestlist.length);
              print(requestlist[0].name);
            });
          }
          print("Done");
          return Container(

            child: ListView.builder(
              itemCount: requestlist.length,
              itemBuilder: (context, index)
              {

               return  PassengerCard(psg: requestlist[index]);
              }
                  ,
            ),
          );
        }
        else{
          return Center(child: Text('No requestor'),);
        }
              }


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