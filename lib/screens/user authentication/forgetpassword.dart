import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
class forgetpassword extends StatefulWidget {


  @override
  _forgetpasswordState createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {

String ?validateEmail (String ?value)
{
  if (value!.isEmpty)
  {
    return "Email Address cannot be empty";
  }
  if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                        return 'Please enter a valid Email';
                      }
                      return null;
}
  bool verified=false;
  final GlobalKey<FormState> _emailverify = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
      child: Form(
        key: _emailverify,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 50,),
                Column(
                  children: [
                    Text('FORGET PASSWORD',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
                    ,
                    SizedBox(height: 20,),
                    Text('Please use an email to \nrestore your password',style: TextStyle(fontSize: 15,color:Colors.green,))
                    ,
                    SizedBox(height: 30,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                      child: TextFormField(


                        textAlignVertical: TextAlignVertical.top,
                        validator: validateEmail,
                        decoration: InputDecoration(
                          filled: true,
                          alignLabelWithHint: true,
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
                    ),
                  SizedBox(height: 40,),
                  ElevatedButton(
                       style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        primary: Colors.blue[900]
    ),
                onPressed: (){
                 if(_emailverify.currentState!.validate())
                            {

                              Navigator.pushNamed(context, '/login');
                            }
                },
                child: Text('Reset password',textAlign: TextAlign.center,style: TextStyle(fontSize:15,color: Colors.white),)
                ),

                  ],
                ),
              ],),
          )
        ),
      ),
    ),
  );
  }
}