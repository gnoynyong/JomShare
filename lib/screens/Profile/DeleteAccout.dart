import 'package:flutter/material.dart';
import 'package:jomshare/screens/user%20authentication/login.dart';
import '../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jomshare/services/userdatabase.dart';
class DeleteAccount extends StatefulWidget {
  final String imageurl;
  final List <dynamic> offeredpools;
  final List <dynamic> requestedpools;
  const DeleteAccount({ Key? key, required this.imageurl, required this.offeredpools, required this.requestedpools }) : super(key: key);

  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
      CollectionReference carpooldb = FirebaseFirestore.instance.collection('carpool');
    Future<void> deleteOfferedCarpool(String pooldocid) async {
     final carpoolsnapshot=await carpooldb.doc(pooldocid).get();
     if (carpoolsnapshot.data()!.containsKey("requestList"))
     {
       List <dynamic> temp= carpoolsnapshot.data()!["requestList"];
       if(temp.length!=0)
       {
  temp.forEach((element) {
      FirebaseFirestore.instance.collection("user").doc(element).update({'Requested carpools':FieldValue.arrayRemove([pooldocid])});
    });
       }

     }

 carpooldb.doc(pooldocid).delete();

  }
  Future<void> deleteIDFromRequestedCarpool(dynamic pooldocid) async {
     final carpoolsnapshot=await carpooldb.doc(pooldocid.toString()).get();
     if (carpoolsnapshot.data()!.containsKey("requestList"))
     {
       List <dynamic> temp= carpoolsnapshot.data()!["requestList"];
       List <dynamic> tempStatus= carpoolsnapshot.data()!["requestStatus"];
       List <dynamic> tempstorestatus=[];
       if(temp.length!=0)
       {
         int index=0;
         print("1:" +FirebaseAuth.instance.currentUser!.uid.toString());
         for (int g=0;g<temp.length;g++)
         {
           print("2:"+temp[g].toString());
           if(FirebaseAuth.instance.currentUser!.uid.toString()==temp[g].toString())
           {
             index=g;
           }
           tempstorestatus.add(tempStatus[g].toString());

         }
         print("3");
         print("index:"+index.toString());
         if (index==0&&temp.length==1)
         {
           print("z");
           carpooldb.doc(pooldocid.toString()).update({
             'requestList':FieldValue.delete(),

           },

           );
           carpooldb.doc(pooldocid.toString()).update({

             'requestStatus':FieldValue.delete(),
           }
           );
         }
         else
         {
           tempstorestatus.removeAt(index);
          print("4");
           carpooldb.doc(pooldocid.toString()).update({'requestList':FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])});
             print("5");
            carpooldb.doc(pooldocid.toString()).set(
              {'requestStatus':FieldValue.delete(),
                'requestStatus':tempstorestatus,
              },
              SetOptions(
                merge: true
              )
              );
         }

        print("6");
       }


     }



  }
    Future<void>deleteUserAccount(String email,String password) async{

      widget.offeredpools.forEach((element) {
        deleteOfferedCarpool(element);

      });
      widget.requestedpools.forEach((element) {
        deleteIDFromRequestedCarpool(element);
      });
    try {
    User? user =await FirebaseAuth.instance.currentUser;
    CollectionReference usersdb = FirebaseFirestore.instance.collection('user');




    AuthCredential credential = EmailAuthProvider.credential(email: email.trim(), password: password.trim());
     final UserDataBaseService userdbservice= new UserDataBaseService(
         uid: FirebaseAuth.instance.currentUser!.uid
        );
      print("yes");
     user!.reauthenticateWithCredential(credential);
      print("yes");
    userdbservice.deleteImageFromStorage(widget.imageurl);
     usersdb.doc(user.uid).delete();
    user.delete();
    print("User is deleted");
    // Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context)=>new login()),(route)=>false);
} on FirebaseAuthException catch (e) {
  if (e.code == 'requires-recent-login') {
    print('The user must reauthenticate before this operation can be executed.');
  }
}


}
   return Scaffold(

      backgroundColor: primaryColor,
body: SingleChildScrollView(
  child:   Form(
    key:_formkey,
    child: Column(
      children: [
Padding(
        padding:EdgeInsets.fromLTRB(20, 90, 20, 30),
      child: Text(
        'LOGIN',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 80,
          color: Colors.black
        ),
      ),
      ),
      SizedBox(height: 40,),
      Padding(

        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextFormField(
          controller: _email,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(
              color: Colors.grey
            ),
            hintText: 'Email Address',
            prefixIcon: Icon(Icons.email
            ,size: 30,color: Colors.black),
            focusedBorder:OutlineInputBorder(

                          borderRadius:BorderRadius.circular(20),
                          borderSide:BorderSide(color: Colors.blue,width: 1)
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(20),
                          borderSide:BorderSide(color: Colors.blue,width: 1)
                        ),
                        errorBorder: OutlineInputBorder(
                           borderRadius:BorderRadius.circular(20),
                          borderSide:BorderSide(color: Colors.red,width: 1)
                        )
          ),
        ),
      )
      ,
        SizedBox(height: 40,),
      Padding(

        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextFormField(
          controller: _password,
          obscureText: true,
          decoration: InputDecoration(
            filled: true,

            fillColor: Colors.white,
            hintStyle: TextStyle(
              color: Colors.grey
            ),
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock
            ,size: 30,color: Colors.black),
            focusedBorder:OutlineInputBorder(

                          borderRadius:BorderRadius.circular(20),
                          borderSide:BorderSide(color: Colors.blue,width: 1)
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(20),
                          borderSide:BorderSide(color: Colors.blue,width: 1)
                        ),
                        errorBorder: OutlineInputBorder(
                           borderRadius:BorderRadius.circular(20),
                          borderSide:BorderSide(color: Colors.red,width: 1)
                        )
          ),
        ),
      )
      ,Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 0)
      ,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        primary: Colors.blue[900]
    ),
          onPressed:()async{
            await deleteUserAccount(_email.text,_password.text);
          Navigator.pushReplacementNamed(context, "/");
          },
          child: Text(
            'Delete Account',
            style: TextStyle(color: Colors.white,fontSize: 20,),
          )),
      ),
      ),
      ]

    )
    ),
),
    );
  }
}
