// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/model/carpool.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jomshare/model/user.dart';

import 'package:jomshare/screens/offerpool/PassengerCard.dart';

class AcceptPool extends StatefulWidget {
  AcceptPool({Key? key, required this.accept}) : super(key: key);
  final CarpoolObject accept;

  @override
  State<AcceptPool> createState() => _AcceptPoolState();
}

class _AcceptPoolState extends State<AcceptPool> {
List <UserData> requestlist=<UserData>[];

  bool _isloading=false;

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> currentpool = FirebaseFirestore.instance
        .collection("carpool")
        .doc(widget.accept.pooldocid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Request"),

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
          if (!snapshot.hasData) {
             return Center(child: Text('No requestor'),);
        }
        if (!snapshot.data!.data()!.containsKey("requestList"))
        {
          return Center(child: Text('No requestor'),);
        }
        List <dynamic> requestorlist=List.from(snapshot.data!.data()!["requestList"]);

           List <dynamic> requestorstatus=List.from(snapshot.data!.data()!["requestStatus"]);

          Stream<QuerySnapshot> userdb=FirebaseFirestore.instance.collection("user").snapshots();

        return StreamBuilder<QuerySnapshot>(
          stream: userdb,
          builder: (context,snapshotx)
          {
            if (snapshotx.connectionState==ConnectionState.waiting)
              {
   return CircularProgressIndicator();

              }
               if (snapshotx.hasError) {
            return Text("Something wrong");
          }
          QuerySnapshot? QS=snapshotx.data;
          int docnum=QS!.size;
           List<QueryDocumentSnapshot>temp=QS.docs;
          int count=0;
          UserData host=new UserData();
          for (int y=0;y<docnum;y++)
              {



                for(int z=0;z<requestorlist.length;z++)
                {
                  print("Compare "+y.toString()+"/"+z.toString()+": ");
                    print("Y element: "+snapshotx.data!.docs.elementAt(y).id);
                     print("Z element: "+requestorlist[z].toString());
                  if(temp.elementAt(y).id==requestorlist[z].toString())
                  {

                    if(requestorstatus[z].toString()=="pending")
                    {
                      UserData userobj= new UserData.set(
                        uid: temp.elementAt(y).id,
                        name: temp.elementAt(y).data()["name"],
                        icNo: temp.elementAt(y).data()["icNo"],
                        gender: temp.elementAt(y).data()["gender"],
                        phone: temp.elementAt(y).data()["phone"],
                        occupation: temp.elementAt(y).data()["occupation"],
                         license: temp.elementAt(y).data()["havelicense"],
                         licenseType: temp.elementAt(y).data()["licenseType"],
                         address: temp.elementAt(y).data()["address"],
                         imageurl: temp.elementAt(y).data()["url"],
                          haveCar: temp.elementAt(y).data()["haveCar"],
                          age:temp.elementAt(y).data()["age"]);
                          print("Y: "+y.toString()+" Z: "+z.toString());
                          print("uid"+userobj.uid);
                           print("name"+userobj.name);
                            print("ic"+userobj.icNo);
                             print("gender"+userobj.gender);
                              print("phone"+userobj.phone);
                               print("occupation"+userobj.occupation);
                                print("license"+userobj.license.toString());
                                 print("licenseType"+userobj.licenseType);
                                  print("address"+userobj.address);
                                   print("url"+userobj.imageurl);
                                    print("car"+userobj.haveCar.toString());
                                     print("age"+userobj.age.toString());
                                  bool check=false;
            int listindex=0;



                                     if (requestlist!=null&&requestlist.length!=0)
                                     {
                                       for (int g=0;g<requestlist.length;g++)
                                       {
                                         check=false;
                                         if(userobj.uid==requestlist[g].uid)
                                         {
                                           check=true;
                                           listindex=g;
                                           break;
                                         }

                                       }
                                       if(check)
                                       {
                                         requestlist.removeAt(listindex);
                                         requestlist.insert(listindex, userobj);
                                       }
                                       else
                                       {
                                         requestlist.add(userobj);
                                       }


                                     }
                                     else
                                     {
                                       requestlist.add(userobj);
                                         print("passenger added");

                                     }

                    }
                    else
                    {
                         bool checkexist=false;
            int listindex=0;
             for (int g=0;g<requestlist.length;g++)
                                       {
                                         checkexist=false;
                                         if(temp.elementAt(y).id==requestlist[g].uid)
                                         {
                                           checkexist=true;
                                           listindex=g;
                                           break;
                                         }

                                       }
                                    if (checkexist)
                                    {
                                       requestlist.removeAt(listindex);

                                    }

                    }

                  }
                }



              }
              if(requestlist.length==0)
              {
                return Center(child: Text("Waiting for requests......",style: TextStyle(fontSize: 20),),);
              }
              return Container(

            child: ListView.builder(
              itemCount: requestlist.length,
              itemBuilder: (context, index)
              {

               return  PassengerCard(psg: requestlist[index],currentpool: snapshot,);
              }
                  ,
            ),
          );






          }




          );

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