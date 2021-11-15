import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/contact/ChatBody.dart';

class ChatPage extends StatefulWidget {
  

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Text("Chats"),
        actions:[
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
        backgroundColor: lightpp,
      ),
      body: ChatBody(),
    );
  }
}