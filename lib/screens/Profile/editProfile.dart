import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/components/smallroundbutton.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/Profile/Info.dart';
import 'package:jomshare/screens/Profile/ProfileBody.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:ui';

import 'package:jomshare/screens/home/home.dart';
import 'package:jomshare/services/userdatabase.dart';
import 'package:jomshare/screens/Profile/DeleteAccout.dart';
class editProfile extends StatefulWidget {


  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  @override
   CollectionReference user = FirebaseFirestore.instance.collection("user");
 File ?_selectedFile;
  bool  _inprocess=true;
  bool _oriImage=true;

  Widget build(BuildContext context) {
     final Stream<DocumentSnapshot> usersnapshot = user.doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
       final _address = TextEditingController();
    final _phone = TextEditingController();
     final _occupation = TextEditingController();
     DocumentReference userinfo=user.doc(FirebaseAuth.instance.currentUser!.uid);

Future<void>updateUser(String x) async{
      String url="";
      final UserDataBaseService userdbservice= new UserDataBaseService(
        uid: FirebaseAuth.instance.currentUser!.uid
        );
        if (_selectedFile!=null)
        {
          url=await userdbservice.uploadImageToFirebase(context, _selectedFile!);
          await userdbservice.deleteImageFromStorage(x);
        }
        if(url!="")
        {
          return userinfo.update({
            "url":url,
        'occupation':_occupation.text,
        'address':_address.text,
        'phone':_phone.text
        }
      ).then((value) => print("User Updated!")).catchError((error)=>print("Fail!"));


        }
        else
        {
           return userinfo.update({

        'occupation':_occupation.text,
        'address':_address.text,
        'phone':_phone.text
        }
      ).then((value) => print("User Updated!")).catchError((error)=>print("Fail!"));


        }

       }

    return StreamBuilder<DocumentSnapshot>(
      stream: usersnapshot,
      builder: (context, snapshot) {
         Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
       _address.text=data["address"];
          _phone.text=data["phone"];
          _occupation.text=data["occupation"];
          String imageurl=data["url"];
          List <dynamic> offeredpool=[];
           List <dynamic> requestedpool=[];
          if(data.containsKey("Offered carpools"))
          {
            offeredpool=data["Offered carpools"];
          }
          if(data.containsKey("Requested carpools"))
          {
             requestedpool=data["Requested carpools"];
          }
          print(requestedpool);

        showImage ()
  {
    if (_selectedFile==null)
    {
      return NetworkImage(data["url"]);


    }
    else
    {
      ImageProvider x=FileImage(_selectedFile!);
      return x;

    }
  }

        return Scaffold(

          appBar: AppBar(
          elevation: 0,
          backgroundColor: darkblue,

          centerTitle: true,
          title: Text("Edit Profile"),

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Center(
                child: Stack(
                  children: [
                    Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context).scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(

                                  fit: BoxFit.cover,
                                  image: showImage() )),

                        ),
                        Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: ()
                          {
                            showModalBottomSheet(
                  context: context,
                   builder: (BuildContext context)
                   {
                        return Container(
                       height: 80,
                       color: Colors.white,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Column(
                             children: [
                               IconButton(
                             onPressed: (){
                               getImage(ImageSource.camera);

                               Navigator.pop(context);


                             },
                              icon: Icon(Icons.camera_alt,)),
                              Text('Choose From Camera')
                             ],
                           )
                           ,
                                Column(
                             children: [
                               IconButton(
                             onPressed: (){
                                getImage(ImageSource.gallery);

                               Navigator.pop(context);



                             },
                              icon: Icon(Icons.file_copy)),
                              Text('Choose From Gallery')
                             ],
                           ),


                         ],

                       ));



                   }
                   );


                          },
                          child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.blue[800],
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),

                        )),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
            labelText: "Phone No",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText:_phone.text,
            hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
            controller: _phone,
      ),
    ),
     Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
            labelText: "Address",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText:_address.text,
            hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
            controller: _address,
      ),
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
            labelText: "Occupation",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText:_occupation.text,
            hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
            controller: _occupation,
      ),
    ),
    SizedBox(height: 30,),
    Padding(
      padding: const EdgeInsets.fromLTRB(27, 10, 27, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RaisedButton(
                      onPressed: (){
                         Navigator.popUntil(context, ModalRoute.withName('/home'));

                         },
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1.5,
                            color: Colors.black),
                      ),
                    ),

                    RaisedButton(
                      onPressed: (){
                          updateUser(imageurl);
                          setState(() {

                          });

                          var snackBar = SnackBar(content: Text('Update successfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      },
                      color: darkblue,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1.5,
                            color: Colors.white),
                      ),
                    )



      ],),
    ),
    SizedBox(height: 20,),
    Center(
      child:  RaisedButton(
                      onPressed: (){
                        showDialog(context: context,
                    builder: (context)
                    {
                      return AlertDialog(
                        title: Text('Delete Account Confirmation'),
                        content: Text("Are you sure to delete this account?"),
                        actions: [
                          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>DeleteAccount(imageurl: imageurl, offeredpools: offeredpool,requestedpools: requestedpool,))
                    );


              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),

                        ],


                      );
                    });



                      },
                      color: Colors.red[600],
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Delete Account",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1.5,
                            color: Colors.white),
                      ),
                    ),
    )




            ],
          ),
        ),


        );
      }
    );
  }

  getImage (ImageSource source) async
{
   final ImagePicker _picker = ImagePicker();
  XFile? image=await _picker.pickImage(source: source);
  if (image!=null)
  {
  File? cropped=await ImageCropper.cropImage(sourcePath: image.path
  ,aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1)
  ,compressQuality:100,
  cropStyle: CropStyle.circle,
  maxHeight: 700,
  maxWidth:700,
  compressFormat:ImageCompressFormat.jpg,
  androidUiSettings:AndroidUiSettings(
    toolbarColor: Colors.blue,
    toolbarTitle:"Profile Image Cropper",

    backgroundColor:Colors.white,
  )
  );
  this.setState(() {
    _selectedFile=cropped ;
    _oriImage=false;
    _inprocess=false;
  });
  }
  else
  {
    this.setState(() {
      _inprocess=false;
    });
  }

}
}