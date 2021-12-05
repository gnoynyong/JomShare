
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/model/carpool.dart';
import 'package:jomshare/screens/Manage/requestBody.dart';
import 'package:jomshare/screens/Manage/manageHome.dart';
import 'package:jomshare/screens/home/home.dart';
import 'package:jomshare/screens/welcome/components/body.dart';
import 'package:jomshare/model/user.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';


class ViewUserProfile extends StatelessWidget {
  final UserData user;
  ViewUserProfile({
    required this.user
  });
   String convert(String x)
  {
    List licensetype=['A','A1','D','DA'];
    List <String> licenselist=x.substring(1).split('/');

   String temp="";

    for (int z =0;z<licenselist.length;z++)
    {
      for (int m=0;m<licensetype.length;m++)
      {
        if (int.parse(licenselist[z])==(m))
        {
          temp=temp+", "+licensetype[m];
        }
      }



    }
    temp=temp.substring(1);
    print (temp);
    return temp;

  }
  Widget license()
  {
    if (user.license)
    {
      String lesen=convert(user.licenseType);

      return ListTile(
  dense:true,

                title:Text("Have License & License Type",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                subtitle: Text("Yes & "+lesen),

              );
    }
    else

    {
      return Center();
    }
  }

_callNumber() async{
  final number = user.phone; //set the number here
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          onPressed: ()
          {
            Navigator.pop(context);

          },
          icon: Icon(Icons.arrow_back),),
          title: const Text("Profile"),
          backgroundColor: lightpp



      ),
      body: Container(

        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              SizedBox(height: 20,),


              Center(
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage:NetworkImage(user.imageurl),
                ),
              ),SizedBox(height: 5,),
                            ListTile(

                dense:true,





                              title:Text("Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                              subtitle: Text(user.name),



                            ),

                            ListTile(

                dense:true,



                              title:Text("Age",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                              subtitle: Text(user.age.toString()),



                            ),

               ListTile(
  dense:true,

                title:Text("Gender",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                subtitle: Text(user.gender),

              ),
               ListTile(
  dense:true,

                title:Text("Occupation",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                subtitle: Text(user.occupation),

              ),
              license(),
              SizedBox(height: 20,),






              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(darkblue),
                      shadowColor: MaterialStateProperty.all(Colors.grey),
                      overlayColor:
                          MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    onPressed: ()async {
                      _callNumber();



                    },
                    child: Padding(
                       padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Wrap(

                        spacing: 10.0,
                        children: [
                          Icon(
                            Icons.phone,
                            size: 30.0,
                          ),
                          Text(

                            "Call",

                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shadowColor: MaterialStateProperty.all(Colors.grey),
                      overlayColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    onPressed: () {


                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Wrap(
                        spacing: 10.0,
                        children: [
                          Icon(
                            Icons.comment,
                            size: 30.0,
                          ),
                          Text(

                            "Chat",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28.0),
                          ),
                        ],
                      ),
                    ),
                  ),




                  ],)








            ],
          ),
        ),
      ),

    );
  }
}