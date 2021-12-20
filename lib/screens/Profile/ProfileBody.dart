import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/components/smallroundbutton.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/Profile/Info.dart';
import 'package:jomshare/screens/user%20authentication/login.dart';
import 'package:jomshare/screens/Profile/editProfile.dart';
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
              onTap: (){
                Navigator.push(
             context,
             MaterialPageRoute(builder: (context)=>editProfile())
             );
              },
              child: Padding(
                padding:EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: SafeArea(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        size: 20,
                        color: darkblue,
                      ),
                      SizedBox(width: 20),
                Text(
                "Edit Profile",
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
                        Icons.privacy_tip,
                        size: 20,
                        color: darkblue,
                      ),
                      SizedBox(width: 20),
                Text(
                "Privacy Policy",
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

            ),
            SizedBox(height: 50,),
            SmallRoundButton(
                 text: 'Sign Out',
                   bckcolor: darkblue,
                        textColor: Colors.white,
                         btnstyle: TextStyle(fontSize: 15.0),
                         press: () async{
                          //  await FirebaseAuth.instance.signOut();
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => login()));

                         }

              )
        ],),
    );
        }
        return Text("Loading");
      }
      );

  }
}