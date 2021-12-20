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
String? gender = "Any";
  RangeValues _currentRangeValues = const RangeValues(0,150);
  String? poolType = "Any";

  bool _isFilter=false;
  List<CarpoolObject> filterCarpoolList=[];
  List <UserData> filteruser = [];
  List <int> filternumaccept=[];
  final Stream<QuerySnapshot> queryCarpool = FirebaseFirestore.instance.collection("carpool").snapshots();
   Future<void>filterCarpool()async{
     filterCarpoolList.clear();
     filternumaccept.clear();
     filteruser.clear();
    filterCarpoolList=carpoollist;


    if (gender!="Any")
    {
        List<int> findGenderIndex=[];

          List <CarpoolObject> templist=[];
        for (int q=0;q<filterCarpoolList.length;q++)
        {
          for (int h=0;h<user.length;h++)
          {
            if (filterCarpoolList[q].hostid==user[h].uid)
            {
               print(user[h].name);
              print(gender);
              print(user[h].gender);

              if (gender==user[h].gender)
              {
                findGenderIndex.add(q);
                break;
              }
            }
          }
        }
        for (int f=0;f<findGenderIndex.length;f++)
        {
          templist.add(filterCarpoolList[findGenderIndex[f]]);

        }
        filterCarpoolList=templist;

    }

    if (poolType!="Any")
    {
        filterCarpoolList=filterCarpoolList.where((element) => element.type==poolType).toList();

    }
    print("A");
    filterCarpoolList=filterCarpoolList.where((element) => element.price>=_currentRangeValues.start&&element.price<=_currentRangeValues.end).toList();
    print("B");
    filterCarpoolList.forEach((element) {
          for (int x=0;x<user.length;x++)
          {
            if (element.hostid==user[x].uid)
            {

              filteruser.add(user[x]);
              print("x:"+x.toString());
              print("name: "+user[x].name);
              break;
            }
          }
        });

    for (int b=0;b<filterCarpoolList.length;b++)
    {
       int passengercount=0;
      if (filterCarpoolList[b].requestid.length==filterCarpoolList[b].requeststatus.length)
      {
        for (int k=0;k<filterCarpoolList[b].requestid.length;k++)
      {
        if(filterCarpoolList[b].requeststatus[k]=="accepted")
        {
          passengercount++;
        }
      }

      }
      print("counter:" +passengercount.toString());
      filternumaccept.add(passengercount);

    }
  }

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

  bool validation(List <CarpoolObject> x, int index)
  {
    bool containRequestList=false;
    for (int i = 0; i < x[index].requestid.length; i++)
    {
      if(x[index].requestid[i]==uid)
      {
        containRequestList=true;
        break;
      }
    }
    print("RequestList is");
    print(containRequestList);
    return containRequestList;
  }

  Widget requestStatus(List <CarpoolObject> x, int index)
  {
    int requestStatusIndex = 0;
    String status="";
    Color buttonColor = Colors.white;
    String word="";
    for (int i = 0; i < x[index].requestid.length; i++)
    {
      if(x[index].requestid[i]==uid)
      {
        requestStatusIndex = i;
        break;
      }
    }

    status=x[index].requeststatus[requestStatusIndex];
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
          print(Csize);
          List<QueryDocumentSnapshot>temp=CQS.docs;

          if(snapshot.hasData)
          {
            carpoollist.clear();
            for(int i=0;i<Csize;i++)
            {
              int lengthStart=CQS.docs.elementAt(i).data()["Pickup address"].toString().length;
              int lengthDestination=CQS.docs.elementAt(i).data()["Pickup address"].toString().length;
              double percentageStart,percentageDestination;
              if (lengthStart<30)
              {
                percentageStart=0.7;
              }
              else if(lengthStart>=30&&lengthStart<60)
              {
                percentageStart=0.5;
              }
              else
              {
                percentageStart=0.3;
              }
              if (lengthDestination<30)
              {
                percentageDestination=0.7;
              }
              else if(lengthDestination>=30&&lengthDestination<60)
              {
                percentageDestination=0.5;
              }
              else
              {
                percentageDestination=0.3;
              }

              if((CQS.docs.elementAt(i).data()["Pickup address"]).toString().contains(widget.start) || widget.start.contains(CQS.docs.elementAt(i).data()["Pickup address"]))
              {
                print(1);
                if((CQS.docs.elementAt(i).data()["Drop address"]).toString().contains(widget.destination) || widget.destination.contains(CQS.docs.elementAt(i).data()["Drop address"]))
                {
             print(2);
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


                }

                else
                {
                  print(3);
                  if(widget.start.similarityTo(CQS.docs.elementAt(i).data()["Pickup address"])>percentageStart && widget.destination.similarityTo(CQS.docs.elementAt(i).data()["Drop address"])>percentageDestination)
                  {
                    print(4);
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
                    print("x");
                    if (CQS.docs.elementAt(i).data().containsKey("requestList"))
                    {
                      obj.addRequestIDWithStatus(CQS.docs.elementAt(i).data()["requestList"],CQS.docs.elementAt(i).data()["requestStatus"]);
                      print("y");
                    }
                    carpoollist.add(obj);
                     print("z");


                  }
                }

              }

              else
              {
                print(5);
                if(widget.start.similarityTo(CQS.docs.elementAt(i).data()["Pickup address"])>percentageStart && widget.destination.similarityTo(CQS.docs.elementAt(i).data()["Drop address"])>percentageDestination)
                {
                  print(6);
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
                 List <CarpoolObject> carpoolToDisplay=[];
              List <UserData> hostToDisplay=[];
              List <int> numacceptToDisplay=[];
              if (_isFilter)
              {
                carpoolToDisplay=filterCarpoolList;
                hostToDisplay=filteruser;
                numacceptToDisplay=filternumaccept;
              }
              else
              {
                carpoolToDisplay=carpoollist;
                hostToDisplay=user;
                numacceptToDisplay=numaccept;
              }
              return Scaffold(
                endDrawer:Drawer(
      child: ListView(
        children:<Widget> [
            Container(
              height: 80,
              child: DrawerHeader(
                child:Center(
                  child: Text("Filter List",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.blue[800]),),
                )
                ),
            ),
            Column(
              children: [
                SizedBox(height: 20,),
                Text("Gender",style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                         Radio<String>(
                    // title: const Text("Male"),
                    value: "Male",
                    groupValue: gender,
                    onChanged: (String? value){
                      setState(() {
                        gender=value;
                      });
                    }),
                    Text("Male"),
                      ],
                    ),
                    Row(
                      children: [
                         Radio<String>(
                    // title:const Text("Female") ,
                    value: "Female",
                    groupValue: gender,
                    onChanged: (String? value){
                      setState(() {
                        gender=value;
                      });
                    }),
                    Text("Female"),
                      ],
                    ),
                    Row(
                      children: [
                         Radio<String>(
                    // title: const Text("Male"),
                    value: "Any",
                    groupValue: gender,
                    onChanged: (String? value){
                      setState(() {
                        gender=value;
                      });
                    }),
                    Text("Any"),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 40,),
            Column(
              children: [
                Text("Price",style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold)),
                SizedBox(height: 20,),
                 RangeSlider(
      values: _currentRangeValues,
      max: 300,
      divisions: 15,
      labels: RangeLabels(
       "RM"+ _currentRangeValues.start.round().toString(),
       "RM"+ _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
    ),
              ],
            ),
            SizedBox(height: 40,),
            Column(
              children: [
                Text("Carpool Type",style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold)),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                         Radio<String>(
                    // title: const Text("Male"),
                    value: "One-Time",
                    groupValue: poolType,
                    onChanged: (String? value){
                      setState(() {
                        poolType=value;
                      });
                    }),
                    Text("One-Time"),
                      ],
                    ),
                    Row(
                      children: [
                         Radio<String>(
                    // title:const Text("Female") ,
                    value: "Frequent",
                    groupValue: poolType,
                    onChanged: (String? value){
                      setState(() {
                        poolType=value;
                      });
                    }),
                    Text("Frequent"),
                      ],
                    ),
                    Row(
                      children: [
                         Radio<String>(
                    // title:const Text("Female") ,
                    value: "Any",
                    groupValue: poolType,
                    onChanged: (String? value){
                      setState(() {
                        poolType=value;
                      });
                    }),
                    Text("Any"),
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child:Text("Reset"),
                  onPressed: (){
                    setState(() {
                      gender="Male";
                      poolType="One-Time";
                       _currentRangeValues = const RangeValues(0,50);
                    });
                  },
                 style: ButtonStyle(
                   backgroundColor:MaterialStateProperty.all<Color>(Colors.white),
                   foregroundColor:MaterialStateProperty.all<Color>(darkblue),
                   side: MaterialStateProperty.all(BorderSide(color: darkblue))
                   ),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    child: Text("Apply"),
                    onPressed:(){


                        filterCarpool();
                      print("AAA");

                        _isFilter=true;

                      Navigator.pop(context);


                    },
                    style: ButtonStyle(
                   backgroundColor:MaterialStateProperty.all<Color>(darkblue),
                   foregroundColor:MaterialStateProperty.all<Color>(Colors.white),
                   ),
                    )
              ],
            ),
        ],
      ),
    ),

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
                body: carpoolToDisplay.length==0?Center(child:Text("There is no matching carpool...",style: TextStyle(
                  fontSize: 20
                ),)):Container(
                  padding: EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: carpoolToDisplay.length,
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
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ViewUserProfile(user: hostToDisplay[index])));
                                  },
                                  child: Image.network(hostToDisplay[index].imageurl),
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
                                            carpoolToDisplay[index].datetime,
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
                                          child:  Text(carpoolToDisplay[index].start),),
                                        ],
                                      ),
                                      Icon(Icons.more_vert),
                                      Row(
                                        children: [
                                          Icon(Icons.arrow_downward),
                                          SizedBox(width: 15.0),
                                          SizedBox(width: 200,
                                          child:  Text(carpoolToDisplay[index].destination),),
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
                                              carpoolToDisplay[index].vehicletype,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              carpoolToDisplay[index].plateNo,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              "RM " + carpoolToDisplay[index].price.toStringAsFixed(2),
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
                                            "Carpool Type : " +carpoolToDisplay[index].type+" carpool",
                                            // style: TextStyle(
                                            //   fontSize: 16.0,
                                            //   fontWeight: FontWeight.bold,
                                            //   color: Colors.grey
                                            // ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0,),

                                      carpoolToDisplay[index].type == "Frequent"
                                      ?
                                        Row(
                                          children: [
                                            Icon(Icons.repeat),
                                            SizedBox(width: 15.0,),
                                            SizedBox(width: 200, child:
                                              Text("Frequent Day: "+ convert(carpoolToDisplay[index].repeatedDay),)

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
                                          Text("Current seat: "+numacceptToDisplay[index].toString()+"/"+carpoolToDisplay[index].seatno.toString())
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

                                      validation(carpoolToDisplay,index)
                                      ?
                                      requestStatus(carpoolToDisplay,index)
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

                ),
                floatingActionButton: Builder(builder:(context)=>
                FloatingActionButton(
                  child: Icon(Icons.filter_alt_outlined),
                  onPressed: (){Scaffold.of(context).openEndDrawer();}
                  ),
                  ),
              );
            }
          );
        }
      );
    }
  }
}
