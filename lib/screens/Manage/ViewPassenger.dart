
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/model/carpool.dart';
import 'package:jomshare/screens/Manage/requestBody.dart';
import 'package:jomshare/screens/Manage/manageHome.dart';
import 'package:jomshare/screens/Profile/ViewUserProfile.dart';
import 'package:jomshare/screens/home/home.dart';
import 'package:jomshare/screens/welcome/components/body.dart';
import 'package:jomshare/model/user.dart';

class ViewPassenger extends StatefulWidget {

  const ViewPassenger({ Key? key,required this.request }) : super(key: key);
  final CarpoolObject request;
  @override
  _ViewPassengerState createState() => _ViewPassengerState();
}

class _ViewPassengerState extends State<ViewPassenger> {
List <UserData> passengerlist=<UserData>[];



  @override


  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> currentpool = FirebaseFirestore.instance
        .collection("carpool")
        .doc(widget.request.pooldocid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
              setState(() {

              });
          },
          icon:Icon(Icons.cached_rounded))
        ],
        leading: IconButton(
          onPressed: ()
          {
            Navigator.pop(context);

          },
          icon: Icon(Icons.arrow_back),),
          title: const Text("View Host and Passengers"),
          backgroundColor: lightpp),


          body:   StreamBuilder<DocumentSnapshot>(
            stream: currentpool,
            builder: (context,snapshot)
            {
              if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
            return Text("Something wrong");
          }
          if (!snapshot.hasData)
          {
            return Text("Loading now");
          }





          Stream<QuerySnapshot> userdb=FirebaseFirestore.instance.collection("user").snapshots();
          return StreamBuilder <QuerySnapshot>(
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
          if (!snapshotx.hasData)
          {
            return Text("Loading now");

          }
          QuerySnapshot? QS=snapshotx.data;
               print(QS);
              int docnum=QS!.size;
          List<QueryDocumentSnapshot>temp=QS.docs;
          int count=0;

          bool requestlistExist=false;
           if(snapshot.data!.data()!.containsKey("requestList"))
          {
            requestlistExist=true;
          }
          else
          {
            return Center(child: Text("No passengers yet",style: TextStyle(fontSize:20,),));
          }
          if(requestlistExist){
            List <dynamic> requestorlist=List.from(snapshot.data!.data()!["requestList"]);

           List <dynamic> requestorstatus=List.from(snapshot.data!.data()!["requestStatus"]);
              for (int y=0;y<docnum;y++)
              {



                for(int z=0;z<requestorlist.length;z++)
                {
                  print("Compare "+y.toString()+"/"+z.toString()+": ");
                    print("Y element: "+snapshotx.data!.docs.elementAt(y).id);
                     print("Z element: "+requestorlist[z].toString());
                  if(temp.elementAt(y).id==requestorlist[z].toString())
                  {

                    if(requestorstatus[z].toString()=="accepted")
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



                                     if (passengerlist!=null&&passengerlist.length!=0)
                                     {
                                       for (int g=0;g<passengerlist.length;g++)
                                       {
                                         check=false;
                                         if(userobj.uid==passengerlist[g].uid)
                                         {
                                           check=true;
                                           listindex=g;
                                           break;
                                         }

                                       }
                                       if(check)
                                       {
                                         passengerlist.removeAt(listindex);
                                         passengerlist.insert(listindex, userobj);
                                       }
                                       else
                                       {
                                         passengerlist.add(userobj);
                                       }


                                     }
                                     else
                                     {
                                       passengerlist.add(userobj);
                                         print("passenger added");

                                     }

                    }
                    else
                    {
                      bool checkexist=false;
            int listindex=0;
             for (int g=0;g<passengerlist.length;g++)
                                       {
                                         checkexist=false;
                                         if(temp.elementAt(y).id==passengerlist[g].uid)
                                         {
                                           checkexist=true;
                                           listindex=g;
                                           break;
                                         }

                                       }
                                    if (checkexist)
                                    {
                                       passengerlist.removeAt(listindex);

                                    }


                    }

                  }
                }



              }}


               return
                 ListView(
                   children: [

                     !requestlistExist?Center():ConstrainedBox(
                   constraints: BoxConstraints(maxHeight: 1000),
                   child:  ListView.builder(
                    shrinkWrap: true,


                      itemCount: passengerlist.length,
                      itemBuilder: (context,index)
                      {
                        return Card(
                          child: InkWell(
                            onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ViewUserProfile(user: passengerlist[index])));


                            },
                            child: ListTile(
                              leading: Image.network(passengerlist[index].imageurl),
                              title: Text("Passenger",style:TextStyle(fontWeight: FontWeight.bold)),

                              subtitle: Text(passengerlist[index].name),

                            ),
                          )
                          ,

                        );

                      }
                      ),


                   )
                   ],
                 );




            }
            );


            }

          )
    );
  }
}