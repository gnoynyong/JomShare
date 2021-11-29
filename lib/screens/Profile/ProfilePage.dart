import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Text("My Profile"),
              CircleAvatar(
                radius:15 ,
                backgroundImage: NetworkImage( "https://static.dw.com/image/53120612_303.jpg"),
              )
            ],
          ),
          Container(
            
          )
        ],
      ),
    );
  }
}