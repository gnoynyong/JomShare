// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/model/carpool.dart';
import 'package:jomshare/model/user.dart';
import 'package:jomshare/screens/Profile/ViewUserProfile.dart';
import 'package:string_similarity/string_similarity.dart';

class findcarpool extends StatefulWidget {
  const findcarpool({Key? key, required this.start, required this.destination}) : super(key: key);

  final String start;
  final String destination;

  @override
  _findcarpoolState createState() => _findcarpoolState();
}

class _findcarpoolState extends State<findcarpool> {
  @override

  bool _ispress=false;
  bool _isloading=false;

  List <int> indexdelete = [];
  List <int> indextodelete = [];

  List <int> numaccept = [];
  List <int> requestListCQSIndex = [];
  List <int> newrequestListCQSIndex = [];
  List <CarpoolObject> carpoollist = [];
  List <UserData> user = [];

  final Stream<QuerySnapshot> queryCarpool = FirebaseFirestore.instance.collection("carpool").snapshots();
  String convert(String x)
  {
    List day=['Mon','Tue','Wed','Thurs','Fri','Sat','Sun'];
    List <String> daylist=x.substring(1).split('/');
    // print(daylist);
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
    // print (temp);
    return temp;
  }

  CollectionReference carpooldb = FirebaseFirestore.instance.collection("carpool");
  CollectionReference userdb = FirebaseFirestore.instance.collection("user");
  String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void>updateCarpool(QuerySnapshot CQS, QuerySnapshot UQS, int index) async {
    for (int i = 0; i < CQS.size; i++)
    {
      // print("uid");
      // print(uid);
      if(CQS.docs.elementAt(i).id==carpoollist[index].pooldocid)
      {
        if(CQS.docs.elementAt(i).data().containsKey("requestList")==true)
        {
          DocumentSnapshot docObj = await carpooldb.doc(CQS.docs.elementAt(i).id).get();

          List cancelList=docObj.data()!["requestStatus"];
          int cancelIndex=0;
          bool RepeatID=false;

          for (int j = 0; j < carpoollist[index].requestid.length; j++)
          {

            print("j");
            print(j);
            print("Carpool requestid");
            print(carpoollist[index].requestid[j]);

            print("Userid");
            print(uid);
            if(carpoollist[index].requestid[j]==uid)
            {
              print("repeatID");
              RepeatID=true;
              if(carpoollist[index].requeststatus[j]=="cancelled")
              {
                cancelIndex=j;
                cancelList[cancelIndex]="pending";
                carpooldb.doc(CQS.docs.elementAt(i).id).set({
                  "requestStatus" : FieldValue.delete(),
                  "requestStatus" : cancelList,
                },SetOptions(merge: true)).then((value) => print("Carpool Request Status delete(In cancel)"))
                .catchError((err) => print("Failed: $err"));
              }
              break;
            }
          }
          if(RepeatID==false)
          {
            print("norepestID");
            // carpooldb.doc(CQS.docs.elementAt(i).id).update({
            //   "requestList" : FieldValue.arrayUnion([uid]),
            //   // "requestStatus" : FieldValue.arrayUnion(["pending"]),
            // }).then((value) => print("Carpool Request Update"))
            // .catchError((err) => print("Failed: $err"));

            DocumentSnapshot x = await carpooldb.doc(CQS.docs.elementAt(i).id).get();
            // List requestorID=x.data()!["requestList"];
            List requestorStatus=x.data()!["requestStatus"];
            // int requestorIndex;

            requestorStatus.add("pending");
            print(requestorStatus);
            // print(carpoollist);

            carpooldb.doc(CQS.docs.elementAt(i).id).set({
              "requestStatus" : FieldValue.delete(),
              "requestStatus" : requestorStatus,
            },SetOptions(merge: true)).then((value) => print("Carpool Request Status delete"))
            .catchError((err) => print("Failed: $err"));

            print("After delete");
            print(requestorStatus);
            print(carpoollist[index].pooldocid);
            print(carpoollist[index].requeststatus);

            carpooldb.doc(CQS.docs.elementAt(i).id).update({
              "requestList" : FieldValue.arrayUnion([uid]),
            }).then((value) => print("Carpool Request list Update"))
            .catchError((err) => print("Failed: $err"));

            print("After update");
            print(requestorStatus);
            print(carpoollist[index].requeststatus);

            // carpooldb.doc(CQS.docs.elementAt(i).id).set({
            //   "requestStatus" : requestorStatus,
            // },SetOptions(merge: true)).then((value) => print("Carpool status Update"))
            // .catchError((err) => print("Failed: $err"));

            // print("After update status");
            // print(requestorStatus);
            // print(carpoollist[index].requeststatus);


            for (int l = 0; l < UQS.size; l++)
            {
              // print("l");
              // print(l);
              // print(UQS.docs.elementAt(l).id);
              if(UQS.docs.elementAt(l).id==uid)
              {
                // print(UQS.docs.elementAt(l).data().containsKey("Requested carpools"));
                if(UQS.docs.elementAt(l).data().containsKey("Requested carpools")==true)
                {
                  return userdb.doc(uid).update({
                    "Requested carpools" : FieldValue.arrayUnion([carpoollist[index].pooldocid])
                  }).then((value) => print("User Request List Update"))
                  .catchError((err) => print("Failed: $err"));
                }
                else
                {
                  return userdb.doc(uid).set({
                    "Requested carpools" : FieldValue.arrayUnion([carpoollist[index].pooldocid])
                  },SetOptions(merge: true)).then((value) => print("User Request List created"))
                  .catchError((err) => print("Failed: $err"));
                }
              }
            }

              // return carpooldb.doc(CQS.docs.elementAt(i).id).update({
              //   "requestList" : FieldValue.arrayUnion([uid]),
              //   "requestStatus" : FieldValue.arrayUnion(["pending"]),
              // }).then((value) => print("Carpool Request Update"))
              // .catchError((err) => print("Failed: $err"));
          }
        }
        else
        {
          carpooldb.doc(CQS.docs.elementAt(i).id).set({
            "requestList" : FieldValue.arrayUnion([uid]),
            "requestStatus" : FieldValue.arrayUnion(["pending"]),
          },SetOptions(merge: true)).then((value) => print("Carpool Request List and Status created"))
          .catchError((err) => print("Failed: $err"));

          for (int l = 0; l < UQS.size; l++)
          {
            if(UQS.docs.elementAt(l).id==uid)
            {
              if(UQS.docs.elementAt(l).data().containsKey("Requested carpools")==true)
              {
                return userdb.doc(uid).update({
                  "Requested carpools" : FieldValue.arrayUnion([carpoollist[index].pooldocid])
                }).then((value) => print("User Request List Update"))
                .catchError((err) => print("Failed: $err"));
              }
              else
              {
                return userdb.doc(uid).set({
                  "Requested carpools" : FieldValue.arrayUnion([carpoollist[index].pooldocid])
                },SetOptions(merge: true)).then((value) => print("User Request List created"))
                .catchError((err) => print("Failed: $err"));
              }
            }
          }
        }
      }
    }
  }

  bool validation(QuerySnapshot CQS, QuerySnapshot UQS, int index)
  {
    bool containRequestList=false;
    for (int i = 0; i < carpoollist[index].requestid.length; i++)
    {
      if(carpoollist[index].requestid[i]==uid)
      {
        containRequestList=true;
        break;
      }
    }
    print("RequestList is");
    print(containRequestList);
    return containRequestList;
  }

  Widget requestStatus(QuerySnapshot CQS, QuerySnapshot UQS, int index)
  {
    int requestStatusIndex = 0;
    String status="";
    Color buttonColor = Colors.white;
    String word="";
    for (int i = 0; i < carpoollist[index].requestid.length; i++)
    {
      if(carpoollist[index].requestid[i]==uid)
      {
        requestStatusIndex = i;
        break;
      }
    }

    status=carpoollist[index].requeststatus[requestStatusIndex];
    switch (status)
    {
      case "pending":
        buttonColor=Colors.purple;
        word="Requested";
        break;

      case "accepted":
        buttonColor=Colors.green;
        word="Accepted";
        break;

      case "rejected":
        buttonColor=Colors.red;
        word="Rejected";
        break;

      case "cancelled":
        buttonColor=Colors.pink;
        word="Cancelled";
        break;
      //   return Container(
      //   alignment: Alignment.centerRight,
      //   child: ElevatedButton(
      //     style: ButtonStyle(backgroundColor: MaterialStateProperty.all(buttonColor)),
      //     onPressed: () => updateCarpool(CQS,UQS,index),
      //     child: Text(word)
      //   ),
      // );
    }

    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(buttonColor)),
        onPressed: (){},
        child: Text(word)
      ),
    );
  }

  Widget build(BuildContext context) {

    if (_isloading)
    {
      return CircularProgressIndicator();
    }
    else
    {
      return StreamBuilder<QuerySnapshot>(
        stream: queryCarpool,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(snapshot.hasError) {
            return Text('Something went wrong');
          }

          // if(snapshot.connectionState == ConnectionState.waiting) {
          //   return Text("Loading");
          // }

          if (!snapshot.hasData){
            return Text("Loading now");
          }

          QuerySnapshot? CQS = snapshot.data;
          int Csize = CQS!.size;
          List<QueryDocumentSnapshot>temp=CQS.docs;

          if(snapshot.hasData)
          {
            carpoollist.clear();
            for(int i=0;i<Csize;i++)
            {
              if((CQS.docs.elementAt(i).data()["Pickup address"]).toString().contains(widget.start) || widget.start.contains(CQS.docs.elementAt(i).data()["Pickup address"]))
              {
                if((CQS.docs.elementAt(i).data()["Drop address"]).toString().contains(widget.destination) || widget.destination.contains(CQS.docs.elementAt(i).data()["Drop address"]))
                {
                  // print(CQS.docs.elementAt(i).data()["Pickup address"]);
                  // print(CQS.docs.elementAt(i).data()["Drop address"]);
                  CarpoolObject obj = new CarpoolObject(
                    hostid: temp.elementAt(i).data()["Host ID"],
                    datetime: temp.elementAt(i).data()["Date Time"],
                    start: temp.elementAt(i).data()["Pickup address"],
                    destination: temp.elementAt(i).data()["Drop address"],
                    vehicletype: temp.elementAt(i).data()["Car type"],
                    plateNo: temp.elementAt(i).data()["Plate no"],
                    price: temp.elementAt(i).data()["Price"],
                    type: temp.elementAt(i).data()["Pool type"],
                    repeatedDay: temp.elementAt(i).data()["Repeated Day"],
                    pooldocid: temp.elementAt(i).id,
                    seatno: temp.elementAt(i).data()["Seat"]
                  );
                  if (CQS.docs.elementAt(i).data()["requestList"]!=null)
                  {
                    obj.addRequestIDWithStatus(CQS.docs.elementAt(i).data()["requestList"],CQS.docs.elementAt(i).data()["requestStatus"]);
                    // print("RequestID: ${obj.requestid}");
                  }
                  carpoollist.add(obj);

                  // bool repeat=false;
                  // int listindex=0;
                  // for (int i = 0; i < carpoollist.length; i++)
                  // {
                  //   repeat=false;
                  //   // print("carpool");
                  //   // print(i);
                  //   if(obj.pooldocid==carpoollist[i].pooldocid)
                  //   {
                  //     // print("Find same");
                  //     repeat=true;
                  //     break;
                  //   }
                  // }
                  // if(repeat==false)
                  // {
                  //   // print("Add carpool");
                  //   carpoollist.add(obj);
                  // }


                  // bool check=false;
                  // int listindex=0;
                  // if (carpoollist!=null&&carpoollist.length!=0)
                  // {
                  //   for (int g=0;g<carpoollist.length;g++)
                  //   {
                  //     check=false;
                  //     if(obj.pooldocid==carpoollist[g].pooldocid)
                  //     {
                  //       check=true;
                  //       listindex=g;
                  //       break;
                  //     }
                  //   }
                  //   if(check)
                  //   {
                  //     carpoollist.removeAt(listindex);
                  //     carpoollist.insert(listindex, obj);
                  //   }
                  //   else
                  //   {
                  //     carpoollist.add(obj);
                  //   }
                  // }
                  // else
                  // {
                  //   carpoollist.add(obj);
                  //   print("carpool added");
                  // }
                }

                else
                {
                  if(widget.start.similarityTo(CQS.docs.elementAt(i).data()["Pickup address"])>0.7 && widget.destination.similarityTo(CQS.docs.elementAt(i).data()["Drop address"])>0.7)
                  {
                    CarpoolObject obj = new CarpoolObject(
                      hostid: temp.elementAt(i).data()["Host ID"],
                      datetime: temp.elementAt(i).data()["Date Time"],
                      start: temp.elementAt(i).data()["Pickup address"],
                      destination: temp.elementAt(i).data()["Drop address"],
                      vehicletype: temp.elementAt(i).data()["Car type"],
                      plateNo: temp.elementAt(i).data()["Plate no"],
                      price: temp.elementAt(i).data()["Price"],
                      type: temp.elementAt(i).data()["Pool type"],
                      repeatedDay: temp.elementAt(i).data()["Repeated Day"],
                      pooldocid: temp.elementAt(i).id,
                      seatno: temp.elementAt(i).data()["Seat"]
                    );
                    if (CQS.docs.elementAt(i).data()["requestList"]!=null)
                    {
                      obj.addRequestIDWithStatus(CQS.docs.elementAt(i).data()["requestList"],CQS.docs.elementAt(i).data()["requestStatus"]);
                      // print("RequestID: ${obj.requestid}");
                    }
                    carpoollist.add(obj);

                    // bool repeat=false;
                    // int listindex=0;
                    // for (int i = 0; i < carpoollist.length; i++)
                    // {
                    //   repeat=false;
                    //   // print("carpool");
                    //   // print(i);
                    //   if(obj.pooldocid==carpoollist[i].pooldocid)
                    //   {
                    //     // print("Find same");
                    //     repeat=true;
                    //     break;
                    //   }
                    // }
                    // if(repeat==false)
                    // {
                    //   // print("Add carpool");
                    //   carpoollist.add(obj);
                    // }

                    // bool check=false;
                    // int listindex=0;
                    // if (carpoollist!=null&&carpoollist.length!=0)
                    // {
                    //   for (int g=0;g<carpoollist.length;g++)
                    //   {
                    //     check=false;
                    //     if(obj.pooldocid==carpoollist[g].pooldocid)
                    //     {
                    //       check=true;
                    //       listindex=g;
                    //       break;
                    //     }
                    //   }
                    //   if(check)
                    //   {
                    //     carpoollist.removeAt(listindex);
                    //     carpoollist.insert(listindex, obj);
                    //   }
                    //   else
                    //   {
                    //     carpoollist.add(obj);
                    //   }
                    // }
                    // else
                    // {
                    //   carpoollist.add(obj);
                    //   print("carpool added");
                    // }
                  }
                }

              }

              else
              {
                if(widget.start.similarityTo(CQS.docs.elementAt(i).data()["Pickup address"])>0.7 && widget.destination.similarityTo(CQS.docs.elementAt(i).data()["Drop address"])>0.7)
                {
                  CarpoolObject obj = new CarpoolObject(
                    hostid: temp.elementAt(i).data()["Host ID"],
                    datetime: temp.elementAt(i).data()["Date Time"],
                    start: temp.elementAt(i).data()["Pickup address"],
                    destination: temp.elementAt(i).data()["Drop address"],
                    vehicletype: temp.elementAt(i).data()["Car type"],
                    plateNo: temp.elementAt(i).data()["Plate no"],
                    price: temp.elementAt(i).data()["Price"],
                    type: temp.elementAt(i).data()["Pool type"],
                    repeatedDay: temp.elementAt(i).data()["Repeated Day"],
                    pooldocid: temp.elementAt(i).id,
                    seatno: temp.elementAt(i).data()["Seat"]
                  );
                  if (CQS.docs.elementAt(i).data()["requestList"]!=null)
                  {
                    obj.addRequestIDWithStatus(CQS.docs.elementAt(i).data()["requestList"],CQS.docs.elementAt(i).data()["requestStatus"]);
                    // print("RequestID: ${obj.requestid}");
                  }
                  carpoollist.add(obj);

                  // bool repeat=false;
                  // int listindex=0;
                  // for (int i = 0; i < carpoollist.length; i++)
                  // {
                  //   repeat=false;
                  //   // print("carpool");
                  //   // print(i);
                  //   if(obj.pooldocid==carpoollist[i].pooldocid)
                  //   {
                  //     // print("Find same");
                  //     repeat=true;
                  //     break;
                  //   }
                  // }
                  // if(repeat==false)
                  // {
                  //   // print("Add carpool");
                  //   carpoollist.add(obj);
                  // }

                  // bool check=false;
                  // int listindex=0;
                  // if (carpoollist!=null&&carpoollist.length!=0)
                  // {
                  //   for (int g=0;g<carpoollist.length;g++)
                  //   {
                  //     check=false;
                  //     if(obj.pooldocid==carpoollist[g].pooldocid)
                  //     {
                  //       check=true;
                  //       listindex=g;
                  //       break;
                  //     }
                  //   }
                  //   if(check)
                  //   {
                  //     carpoollist.removeAt(listindex);
                  //     carpoollist.insert(listindex, obj);
                  //   }
                  //   else
                  //   {
                  //     carpoollist.add(obj);
                  //   }
                  // }
                  // else
                  // {
                  //   carpoollist.add(obj);
                  //   print("carpool added");
                  // }
                }
              }
            }

            // print(Csize);

            numaccept.clear();
            for(int i = 0; i < Csize ; i++)
            {
              // print("new carpool");
              // print(CQS.docs.elementAt(i).id);

              int number = 0;
              for(int k=0;k<carpoollist.length;k++)
              {
                // print(carpoollist[k].pooldocid);
                if(CQS.docs.elementAt(i).id==carpoollist[k].pooldocid)
                {
                  if(CQS.docs.elementAt(i).data().containsKey("requestList")==true)
                  {
                    requestListCQSIndex.add(i);
                    for (int j = 0; j < carpoollist[k].requeststatus.length; j++)
                    {
                      // print("requeststatus.length");
                      // print(carpoollist[k].requeststatus.length);
                      // print("requeststatus");
                      // print(carpoollist[k].requeststatus);
                      if(carpoollist[k].requeststatus.elementAt(j)=="accepted")
                      {
                        number++;
                      }
                    }
                  }
                  numaccept.add(number);
                }
              }
            }
            // print(requestListCQSIndex); //no use

            // print(numaccept);
            // print(carpoollist.length);

            for (int i = carpoollist.length-1; i >= 0; i--)
            {
              if(carpoollist[i].seatno==numaccept[i])
              {
                carpoollist.removeAt(i);
                numaccept.removeAt(i);
              }
            }

            final FirebaseAuth auth = FirebaseAuth.instance;
            final User? user = auth.currentUser;
            final uid = user!.uid;
            print("UID:");
            print(uid);
            for (int i = carpoollist.length-1; i >= 0; i--)
            {
              print("HostID:");
              print(carpoollist[i].hostid);
              if(carpoollist[i].hostid==uid)
              {
                carpoollist.removeAt(i);
                numaccept.removeAt(i);
              }
            }
            print("carpool list length after: ");
            print(carpoollist.length);
            for (int i = 0; i < carpoollist.length; i++)
            {
              print("hostid");
              print(carpoollist[i].hostid);
            }


            // print("Numaccept after: ");
            // print(numaccept);


            // print("index[1]: ");
            // print(requestListCQSIndex[1]);

            // for (int i = 0; i < requestListCQSIndex.length; i++)
            // {
            //   for (int j = 0; j < carpoollist.length; j++)
            //   {
            //     if(CQS.docs.elementAt(requestListCQSIndex[i]).id==carpoollist[j].pooldocid)
            //     {
            //       newrequestListCQSIndex.add(requestListCQSIndex[i]);
            //     }
            //   }
            // }
            // print("New request list index: ");
            // print(newrequestListCQSIndex);
          }
          Stream<QuerySnapshot> queryuser = FirebaseFirestore.instance.collection("user").snapshots();
          return StreamBuilder <QuerySnapshot>(
            stream: queryuser,
            builder: (context,snapshotu){
              if(snapshotu.hasError) {
                return Text('Something went wrong');
              }
              // if(snapshotu.connectionState == ConnectionState.waiting) {
              //   return Text("Loading");
              // }
              if (!snapshotu.hasData){
                return Text("Loading now");
              }

              QuerySnapshot? UQS = snapshotu.data;
              int Usize = UQS!.size;
              List<QueryDocumentSnapshot>utemp = UQS.docs;
              if(snapshotu.hasData)
              {
                user.clear();
                // print(user.length);
                UserData host = new UserData();
                for(int h=0;h<carpoollist.length;h++)
                {
                  for(int k=0;k<Usize;k++)
                  {
                    // print("carpool host id is "+carpoollist[h].hostid+" and UQS id is"+UQS.docs.elementAt(k).id);
                    if(carpoollist[h].hostid==UQS.docs.elementAt(k).id)
                    {
                      // print("h is "+h.toString()+" and k is "+k.toString());
                      host=new UserData.set(
                        uid: utemp.elementAt(k).id,
                        name: utemp.elementAt(k).data()["name"],
                        icNo: utemp.elementAt(k).data()["icNo"],
                        gender: utemp.elementAt(k).data()["gender"],
                        phone: utemp.elementAt(k).data()["phone"],
                        occupation: utemp.elementAt(k).data()["occupation"],
                        license: utemp.elementAt(k).data()["havelicense"],
                        licenseType: utemp.elementAt(k).data()["licenseType"],
                        address: utemp.elementAt(k).data()["address"],
                        imageurl: utemp.elementAt(k).data()["url"],
                        haveCar: utemp.elementAt(k).data()["haveCar"],
                        age: utemp.elementAt(k).data()["age"]
                      );
                      // print(host.uid);
                      user.add(host);
                      // print(user[k].name);
                      break;

                      // bool repeat=false;
                      // int listindex=0;
                      // for (int i = 0; i < user.length; i++)
                      // {
                      //   repeat=false;
                      //   print("User");
                      //   print(i);
                      //   if(host.uid==user[i].uid)
                      //   {
                      //     print("Find same user");
                      //     repeat=true;
                      //     break;
                      //   }
                      // }
                      // if(repeat==false)
                      // {
                      //   print("Add user");
                      //   user.add(host);
                      // }

                      // bool check=false;
                      // int listindex=0;
                      // if (user!=null&&user.length!=0)
                      // {
                      //   for (int g=0;g<user.length;g++)
                      //   {
                      //     check=false;
                      //     if(host.uid==user[g].uid)
                      //     {
                      //       check=true;
                      //       listindex=g;
                      //       break;
                      //     }
                      //   }
                      //   if(check)
                      //   {
                      //     user.removeAt(listindex);
                      //     user.insert(listindex, host);
                      //   }
                      //   else
                      //   {
                      //     user.add(host);
                      //   }
                      // }
                      // else
                      // {
                      //   user.add(host);
                      //   print("passenger added");
                      // }
                    }
                  }
                }
              }
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: (){
                      setState(() {});},
                      icon:Icon(Icons.cached_rounded)
                    )
                  ],
                  leading: IconButton(
                    onPressed: (){
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  title: const Text("Matching Carpool List"),
                  backgroundColor: lightpp
                ),
                body: Container(
                  padding: EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: carpoollist.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ViewUserProfile(user: user[index])));
                                  },
                                  child: Image.network(user[index].imageurl),
                                )
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.date_range),
                                          SizedBox(width: 15.0,),
                                          Text(
                                            carpoollist[index].datetime,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ]
                                      ),
                                      SizedBox(height: 15.0),
                                      Row(
                                        children: [
                                          Icon(Icons.airport_shuttle),
                                          SizedBox(width: 15.0),
                                          SizedBox(width: 200,
                                          child:  Text(carpoollist[index].start),),
                                        ],
                                      ),
                                      Icon(Icons.more_vert),
                                      Row(
                                        children: [
                                          Icon(Icons.arrow_downward),
                                          SizedBox(width: 15.0),
                                          SizedBox(width: 200,
                                          child:  Text(carpoollist[index].destination),),
                                        ],
                                      ),
                                      SizedBox(height: 15.0,),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              "Vehicle Type :",
                                              // style: TextStyle(
                                              //   fontSize: 16.0,
                                              //   fontWeight: FontWeight.bold,
                                              //   color: Colors.grey
                                              // ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              "Plate No :",
                                              // style: TextStyle(
                                              //   fontSize: 16.0,
                                              //   fontWeight: FontWeight.bold,
                                              //   color: Colors.grey
                                              // ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Price :",
                                              // style: TextStyle(
                                              //   fontSize: 16.0,
                                              //   fontWeight: FontWeight.bold,
                                              //   color: Colors.grey
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(height: 5.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              carpoollist[index].vehicletype,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              carpoollist[index].plateNo,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              "RM " + carpoollist[index].price.toStringAsFixed(2),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0,),
                                      Row(
                                        children: [
                                          Icon(Icons.settings),
                                          SizedBox(width: 15.0),
                                          Text(
                                            "Carpool Type : " +carpoollist[index].type+" carpool",
                                            // style: TextStyle(
                                            //   fontSize: 16.0,
                                            //   fontWeight: FontWeight.bold,
                                            //   color: Colors.grey
                                            // ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0,),

                                      carpoollist[index].type == "Frequent"
                                      ?
                                        Row(
                                          children: [
                                            Icon(Icons.repeat),
                                            SizedBox(width: 15.0,),
                                            SizedBox(width: 200, child:
                                              Text("Frequent Day: "+ convert(carpoollist[index].repeatedDay),)

                                            // style: TextStyle(
                                            //   fontSize: 16.0,
                                            //   fontWeight: FontWeight.bold,
                                            //   color: Colors.grey),
                                            )
                                          ],
                                        )
                                      : Container(),
                                      SizedBox(height: 10.0,),

                                      // (temp.elementAt(temp.indexOf(carpoollist[index].pooldocid)).data().containsKey(["requestList"]))
                                      // (CQS.docs.contains(carpoollist[index].pooldocid))
                                      // (FirebaseFirestore.instance.collection("carpool").doc(carpoollist[index].pooldocid).get().then((value) => value.data()!.containsKey(["requestList"]==true)))
                                      // (CQS.docs.forEach((element) {
                                      //   if(element.id==carpoollist[index].pooldocid)
                                      //   {
                                      //     element.data().containsKey(["requestList"])==true;
                                      //   }
                                      // }))

                                      // (CQS.docs.elementAt(newrequestListCQSIndex[index]).data().containsKey(["requireList"]))
                                      // ?
                                      Row(
                                        children: [
                                          Icon(Icons.format_list_numbered),
                                          SizedBox(width: 15.0,),
                                          Text("Current seat: "+numaccept[index].toString()+"/"+carpoollist[index].seatno.toString())
                                        ],
                                      ),
                                      // :
                                      // Row(
                                      //   children: [
                                      //     Icon(Icons.format_list_numbered),
                                      //     SizedBox(width: 15.0,),
                                      //     Text("Current seat: "+0.toString()+"/"+carpoollist[index].seatno.toString())
                                      //   ],
                                      // ),

                                      SizedBox(height: 10.0,),

                                      validation(CQS,UQS,index)
                                      ?
                                      requestStatus(CQS,UQS,index)
                                      :
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          style: ButtonStyle(backgroundColor: _ispress ? MaterialStateProperty.all(Colors.red) : MaterialStateProperty.all(Colors.blue)),
                                          onPressed: () => updateCarpool(CQS,UQS,index),
                                          child: Text("Request")
                                        ),
                                      )
                                    ]
                                  ),
                                ),
                              )
                            ],
                          )
                        )
                      );
                    }
                  ),
                )
              );
            }
          );
        }
      );
    }
  }
}
