
import 'package:flutter/cupertino.dart';
import 'package:jomshare/constants.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/screens/home/home.dart';
import 'package:jomshare/screens/user%20authentication/forgetpassword.dart';
import 'package:jomshare/services/auth.dart';
class login extends StatefulWidget
{
  State <login> createState() =>loginState();
}

class loginState extends State <login>
{
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final AuthService _auth = AuthService();
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
String ?validatePassword (String ?value)
{
    if (value!.isEmpty)
  {
    return "The password cannot be empty";
  }
  if(value.length<6||value.length>20)
  {
    return 'At least 6 characters and not more than 20 characters';
  }
}

  Widget build (BuildContext context)
  {

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
          controller: email,
          validator: validateEmail,
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
          controller: pass,
          obscureText: true,
          validator: validatePassword,
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
      ,Padding(padding:EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextButton(
        onPressed: (){
          Navigator.pushNamed(context, '/forgetpass');
        },
        child: Text('Forget Password?',
        style: TextStyle(color: Colors.blue[900]
        ,fontSize: 18),
        ),
      ), )
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
           onPressed: () async {
                          if(!_formkey.currentState!.validate())
                          {


                          }
                          else
                          {
                            dynamic result = await _auth.signInWithEmailAndPassword(email.text, pass.text);
                            if (result==null)
                            {
                              showAlert(context);


                            }
                            else
                            {
                              Navigator.pushNamed(context, '/home');
                            }
                          }


                      },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white,fontSize: 20,),
          )),
      ),
      ),
      SizedBox(height: 50,),
      Padding(padding: EdgeInsets.fromLTRB(100, 20, 20, 0)
      ,
      child: Row(children: [
        Text("Don't have account?"
        ,style: TextStyle(color: Colors.black,fontSize: 16),)
      ,
      TextButton(onPressed: (){
        Navigator.pushNamed(context, '/register');
      }, child: Text('Sign Up',style: TextStyle(color: Colors.blue[900],fontSize:20,)))],),)
      ]

    )
    ),
),
    );
  }
  void showAlert(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Error'),
                content: Text("Invalid Credentials"),
                actions: [
                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
                ],
              ));
    }
}