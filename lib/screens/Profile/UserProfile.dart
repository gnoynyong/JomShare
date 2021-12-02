import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/Profile/ProfileBody.dart';
import 'package:jomshare/screens/Profile/SettingsUI.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({ Key? key }) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      backgroundColor: darkblue,
      leading: SizedBox(),
      // On Android it's false by default
      centerTitle: true,
      title: Text("Profile"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
           Navigator.push(
             context,
             MaterialPageRoute(builder: (context)=>SettingsUI())
             );
          },
          child: Text(
            "Edit",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0, //16
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
      body:ProfileBody(),
    );
  }
}

