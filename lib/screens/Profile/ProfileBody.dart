import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/Profile/Info.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection("user");
    final Stream<DocumentSnapshot> usersnapshot = user.doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
    
    return StreamBuilder<DocumentSnapshot>(
      stream: usersnapshot,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasError){
          return Text("Something went wrong");
        }
        if(snapshot.hasData){
           Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
           String? email =  FirebaseAuth.instance.currentUser!.email;
            return SingleChildScrollView(
      child: Column(
        children:<Widget> [
          Info(
            name: data["name"], 
            email:email, 
            image: data["url"],
            ),
            InkWell(
              onTap: (){},
              child: Padding(
                padding:EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: SafeArea(
                  child: Row(
                    children: [
                      Icon(
                        Icons.car_rental,
                        size: 20,
                        color: darkblue,
                      ),
                      SizedBox(width: 20),
                Text(
                "My Vehicle",
                style: TextStyle(
                  fontSize: 16, //16
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.black,
              )
                    ],
                  ),
                  ),
                ),

            ),
             InkWell(
              onTap: (){},
              child: Padding(
                padding:EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: SafeArea(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_city,
                        size: 20,
                        color: darkblue,
                      ),
                      SizedBox(width: 20),
                Text(
                "Manage Address",
                style: TextStyle(
                  fontSize: 16, //16
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.black,
              )
                    ],
                  ),
                  ),
                ),

            ),
             InkWell(
              onTap: (){},
              child: Padding(
                padding:EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: SafeArea(
                  child: Row(
                    children: [
                      Icon(
                        Icons.help_center,
                        size: 20,
                        color: darkblue,
                      ),
                      SizedBox(width: 20),
                Text(
                "Help",
                style: TextStyle(
                  fontSize: 16, //16
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.black,
              )
                    ],
                  ),
                  ),
                ),

            )
        ],),
    );
        }
        return Text("Loading");
      }
      );
   
  }
}