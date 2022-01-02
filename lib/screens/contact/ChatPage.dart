import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/contact/Chart_Card.dart';
import 'package:jomshare/services/userdatabase.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //get chatrooms list from db
 Stream<QuerySnapshot>? chatroomStream;

  Future<Stream<QuerySnapshot>> getChatRooms() async{ 
    return FirebaseFirestore.instance
        .collection("Chatroom")
        .orderBy("lastMessageSendTS", descending: true)
        .where("users", arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  getChatroomStream()async{
    chatroomStream = await getChatRooms();
    setState(() {});
  }
  @override
  void initState() {
    getChatroomStream();
    super.initState();
  }
  
  Widget chatroomlist(){
    return StreamBuilder<QuerySnapshot>(
              stream: chatroomStream,
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                return snapshot.hasData
                ?ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  print("hasdata");
                  String userid = "";
                  if(ds["users"][0]==FirebaseAuth.instance.currentUser!.uid){
                    userid = ds["users"][1];
                    print(userid);
                  }
                  else{
                    userid = ds["users"][0];
                    print(userid);
                  }
                  DateTime dt = ds["lastMessageSendTS"].toDate();
                  String time = DateFormat('hh:mm a').format(dt);
                  return ChatCard(ds["lastMessage"],time, userid);
                })
                :Center(child: CircularProgressIndicator());
              },
            );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Text("Chats"),
        backgroundColor: darkblue,
      ),
      body: Column(
        children: [
          chatroomlist()
        ],
        ),
    );
  }
}