import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/contact/Chat.dart';

import 'Chart_Card.dart';



class ChatBody extends StatefulWidget {
  const ChatBody({ Key? key }) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
         Expanded(
           child: ListView.builder(
             itemCount: chatsData.length,
             itemBuilder:(context,index)=>
             ChatCard(chat:chatsData[index],
             press: (){},
             ) 
             ) 
           )
      ]
    );
  }
}

