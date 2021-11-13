import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jomshare/screens/user%20authentication/license.dart';
class createProfile extends StatefulWidget {


  @override
  _createProfileState createState() => _createProfileState();
}

class _createProfileState extends State<createProfile> {
  final GlobalKey<FormState> _profileform = GlobalKey<FormState>();
  var password;
bool ?L1,L2,L3,L4,L5;

String ?_gender='Male';
String ?validate (String ?value)
{
    if (value!.isEmpty)
  {
    return "The spaces cannot be empty";
  }

}
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
      key: _profileform,
      child: SingleChildScrollView(
        child: Column(


        children: [
          avatar(),
          SizedBox(height: 20,),
          TextFormField(
            validator: validate,

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
            validator: validate,

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

            validator: validate,
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
            validator: validate,

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              hintText: 'Address',
              prefixIcon: Icon(Icons.home
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
            validator: validate,

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
          SizedBox(height: 10,),
          Container(

            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue,width: 1)

              ,
              color: Colors.white,

            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: [

                  Icon(Icons.calendar_today,size: 30,),
                  SizedBox(width: 8,),
                  Text('DOB',style: TextStyle(fontSize:20,color:Colors.black,fontWeight: FontWeight.bold)),
                  SizedBox(width: 20,),
                  DropdownButton(
                    value:_gender,
                    items: [
                      DropdownMenuItem(child: Text('Male',style: TextStyle(fontSize: 20),),value: 'Male',),
                      DropdownMenuItem(child: Text('Female',style: TextStyle(fontSize: 20)),value: 'Female',),
                    ],
                    onChanged: (String ?value){
                      setState(() {
                        _gender=value;
                      });
                    },
                  )

                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
           ElevatedButton(
                        style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        primary: Colors.blue[900]
    ),
                      onPressed: (){
                          if(_profileform.currentState!.validate())
                          {
                              Navigator.pushNamed(context, '/login');
                          }

                      },
                      child: Text('Complete',
                      style: TextStyle(
                        fontSize:20
                      ),
                      ))
        ],
      ),
    ),
    ))
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