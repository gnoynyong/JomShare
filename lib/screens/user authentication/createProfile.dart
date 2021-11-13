import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:image_picker/image_picker.dart';
class createProfile extends StatefulWidget {


  @override
  _createProfileState createState() => _createProfileState();
}

class _createProfileState extends State<createProfile> {


  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: primaryColor,
    appBar: AppBar(
      centerTitle: true,
      title: Text('Create Your Profile',),
      elevation: 0,
      backgroundColor: lightpp,
      leading: IconButton(
        onPressed:(){
          Navigator.pop(context);
        }
      , icon: Icon(Icons.arrow_back_ios_new
      ,color: Colors.white,)),

    ),
    body: Padding(padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20)
    ,
    child: Form(
      child: ListView(
        children: [
          avatar(),
          SizedBox(height: 20,),
          TextFormField(

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              hintText: 'Name',
              prefixIcon: Icon(Icons.person
              ,size: 30,color: Colors.black),
              focusedBorder:OutlineInputBorder(


                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          enabledBorder:OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          errorBorder: OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.red,width: 1)
                          )
            ),

          ),
          SizedBox(height: 10,),
          TextFormField(

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              hintText: 'IC Number',
              prefixIcon: Icon(Icons.person
              ,size: 30,color: Colors.black),
              focusedBorder:OutlineInputBorder(


                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          enabledBorder:OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          errorBorder: OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.red,width: 1)
                          )
            ),

          ),
          SizedBox(height: 10,),
          TextFormField(

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              hintText: 'Phone Number',
              prefixIcon: Icon(Icons.phone
              ,size: 30,color: Colors.black),
              focusedBorder:OutlineInputBorder(


                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          enabledBorder:OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          errorBorder: OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.red,width: 1)
                          )
            ),

          ),
          SizedBox(height: 10,),
          TextFormField(

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              hintText: 'Occupation',
              prefixIcon: Icon(Icons.business
              ,size: 30,color: Colors.black),
              focusedBorder:OutlineInputBorder(


                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          enabledBorder:OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          errorBorder: OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.red,width: 1)
                          )
            ),

          ),
        ],
      ),
    ),
    )
    );
  }
  Widget avatar ()
{
return Stack(
      children: [

        Center(
          child: CircleAvatar(
              radius: 80,
          backgroundImage: AssetImage('assets/image/avatar.jfif')
          ,

            ),
        )
          ,
          Positioned(
            bottom: 20,
            right: 40,
            child: InkWell(
              onTap: (){

              },
              child: Icon(
                  Icons.camera_alt,
                  color: Colors.teal,
                  size: 28,

              ),
            )
          ),
      ],

    );
}
}