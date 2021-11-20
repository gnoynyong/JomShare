import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class signUpScreen extends StatefulWidget {


  _signUpScreenState createState() => _signUpScreenState();
}

class _signUpScreenState  extends State<signUpScreen> {
  @override
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  var password;
Widget build (BuildContext context)
{
  return Scaffold(
    backgroundColor: primaryColor,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: lightpp,
      leading: IconButton(
        onPressed:(){
          Navigator.pop(context);
        }
      , icon: Icon(Icons.arrow_back_ios_new
      ,color: Colors.white,)),

    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(

            children: [
              SizedBox(height: 20,),
              Column(
                children: [
                  Text('Sign up',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
                  ,SizedBox(height: 20,)
                  ,Text(
                    "Create an Account, It's free",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                  ),

                ],
              ),
              SizedBox(height: 30,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 40)
              ,
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Text('Email Address'
                    ,style: TextStyle(
                      fontSize: 15
                    ),),
                    SizedBox(height: 10,),
                    TextFormField(

                      validator: (value)
                      {
                         if (value!.isEmpty)
  {
    return "Email Address cannot be empty";
  }
  if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                        return 'Please enter a valid Email';
                      }
                      return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:Colors.white,
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
                    SizedBox(height: 20,),
                     Text('Password'
                    ,style: TextStyle(
                      fontSize: 15
                    ),),
                    SizedBox(height: 10,),
                    TextFormField(

                      controller: _pass,
                      validator: (value)
                      {
                        password=value;
  if (value!.isEmpty)
  {
    return "The password cannot be empty";
  }
  if(value.length<6||value.length>20)
  {
    return 'At least 6 characters and not more than 20 characters';
  }
                      },
                      obscureText: true,

                      decoration: InputDecoration(
                        filled: true,
                        fillColor:Colors.white,

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
                    SizedBox(height: 20,),
                     Text('Confirm Password'
                    ,style: TextStyle(
                      fontSize: 15
                    ),),
                    SizedBox(height: 10,),
                    TextFormField(

                      validator: (value)
                      {
                          if (value!.isEmpty)
  {
    return "The confirm password cannot be empty";
  }
  if(value!=password)
  {
    return 'The confirm password must match with the password';
  }
  return null;
                      },
                      obscureText: true,

                      decoration: InputDecoration(
                        filled: true,
                        fillColor:Colors.white,

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
                    SizedBox(height: 30,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        primary: Colors.blue[900]
    ),
                      onPressed: (){
                          if(_form.currentState!.validate())
                          {
                              Navigator.pushNamed(context, '/register/createProfile');
                          }

                      },
                      child: Text('Next',
                      style: TextStyle(
                        fontSize:20
                      ),
                      ))
                      ,
                      SizedBox(height:20),
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        child: Row(
                          children: [
                            Text('Already have an account? '),
                            TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text('Login',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 23,color: background
                              ),),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),)
            ],
          ),
        ),
      ),
    ),
  );
}

}