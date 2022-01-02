import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/screens/contact/ChatScreen.dart';
import 'package:jomshare/services/userdatabase.dart';


class ChatCard extends StatefulWidget {
  String userid = "";
  String lastMessage="";
  String lastMessageTS="";
  ChatCard(this.lastMessage,this.lastMessageTS,this.userid);

  @override
  _ChatCardState createState() => _ChatCardState();
}

  class _ChatCardState extends State<ChatCard>{
  String username = "";
  String imageURL = "";
  String myusername = "";
  
  getUserInfo()async{
    myusername = await UserDataBaseService(uid:FirebaseAuth.instance.currentUser!.uid).getUserName();
    username = await UserDataBaseService(uid: widget.userid).getUserName();
    imageURL = await UserDataBaseService(uid: widget.userid).getUserImage();
    setState(() {
    });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
         Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(username, myusername,imageURL)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0, vertical:15.0),
        child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage:NetworkImage(imageURL),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(username,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Opacity(
                  opacity: 0.64,
                  child: Text(widget.lastMessage,maxLines: 1,overflow: TextOverflow.ellipsis),
                  ),
              ],
              ),
            ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text(widget.lastMessageTS),
              )
        ],
      ),
      ),
    );
  }
}