import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/services/userdatabase.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUsername, myname;
  final String profileURL;
  ChatScreen(this.chatWithUsername,this.myname,this.profileURL);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //data need
  String chatroomID = "";
  String messageID = "";
  String profilepicurl = "";
  String myUsername= "";
  Stream<QuerySnapshot>? messageStream;
  TextEditingController messageController = TextEditingController();
  //push message to db
  Future pushMessagetoDB(String chatroomID, String messageID,Map<String,dynamic> messageMap) async{
    return FirebaseFirestore.instance
    .collection("Chatroom")
    .doc(chatroomID)
    .collection("Message")
    .doc(messageID)
    .set(messageMap);
  }
  Future<Stream<QuerySnapshot>> getChatroomMessage(chatroomID)async{
    return FirebaseFirestore.instance
    .collection("Chatroom")
    .doc(chatroomID)
    .collection("Message")
    .orderBy("ts",descending: true)
    .snapshots();
  }

  updateLastMessage(String chatroomID, Map<String,dynamic> lastMessageMap){
    return FirebaseFirestore.instance
    .collection("Chatroom")
    .doc(chatroomID)
    .update(lastMessageMap);
  }

  getInformation()async{
    myUsername = await UserDataBaseService(uid:FirebaseAuth.instance.currentUser!.uid).getUserName();
    chatroomID = getChatroomIdByUsername(widget.chatWithUsername, myUsername);
  }

  getChatroomIdByUsername(String a, String b){
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }
    else{
      return "$a\_$b";
    }
  }
  addMessage(){
    if(messageController.text!=""){
      String message = messageController.text;
      var lastMessageTS = DateTime.now();
      Map<String,dynamic> messageMap = {
        "message":message,
        "sendBy":myUsername,
        "ts":lastMessageTS,
      };

      if(messageID==""){
        messageID = randomAlpha(12);
      }
      pushMessagetoDB(chatroomID, messageID, messageMap)
      .then((value){
              Map<String,dynamic> lastMessageMap={
                "lastMessage":message,
                "lastMessageSendTS":lastMessageTS,
                "lastMessageSendBy":myUsername
              };
              updateLastMessage(chatroomID, lastMessageMap);

                messageController.text="";
                messageID="";

      });

    }
  }

   Widget chatMessageTile(String message, bool sendByMe,Timestamp timestampx) {
     var dateFormat = DateFormat("dd-MM-yyyy hh:mm aa");
      var utcDate = dateFormat.format(DateTime.parse(timestampx.toDate().toString()));

    double left,right;
    if (sendByMe)
    {
      left=0;
      right=15;
    }
    else
    {
      left=15;
      right=0;

    }
    return Column(

      children: [
        Row(
          mainAxisAlignment:
              sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomRight:
                          sendByMe ? Radius.circular(0) : Radius.circular(24),
                      topRight: Radius.circular(24),
                      bottomLeft:
                          sendByMe ? Radius.circular(24) : Radius.circular(0),
                    ),
                    color: sendByMe ? Colors.blue : Colors.white,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    message,
                    style: sendByMe?TextStyle(color: Colors.white):TextStyle(color: Colors.black),
                  )),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(left, 5, right, 5),
          alignment: sendByMe?Alignment.bottomRight:Alignment.bottomLeft,
          child: Text(
                      utcDate,
                      style: sendByMe?TextStyle(color: Colors.white):TextStyle(color: Colors.white),
                    ),
        )
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: messageStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 70, top: 16),
                itemCount: snapshot.data!.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return chatMessageTile(
                      ds["message"], myUsername == ds["sendBy"],ds["ts"]);
                })

          // StickyGroupedListView<QueryDocumentSnapshot,DateTime>(
          //   floatingHeader: true,
          //     elements: snapshot.data!.docs,
          //     order:StickyGroupedListOrder.ASC,

          //     groupBy: (element)
          //     {
          //       Timestamp timestampdatetime=element.data()["ts"];
          //       DateTime time=timestampdatetime.toDate();
          //       return time;
          //     },
          //     groupComparator:(DateTime value1, DateTime value2)
          //     {
          //       return value2.compareTo(value1);

          //     },
          //     itemComparator: ( element1, element2)
          //     {
          //       Timestamp t1=element1.data()["ts"];
          //       Timestamp t2=element2.data()["ts"];
          //      return t1.toDate().compareTo(t2.toDate());

          //     },
          //     groupSeparatorBuilder: (element)
          //     {
          //       Timestamp ts=element.data()["ts"];
          //       return Container(
          //         height: 50,
          //         child: Align(
          //           alignment: Alignment.center,
          //           child: Container(
          //             width: 120,
          //             decoration: BoxDecoration(
          //               color: Colors.blue[300],
          //               border: Border.all(
          //           color: Colors.white,
          //         ),
          //         borderRadius: BorderRadius.all(Radius.circular(20.0)),

          //             ),
          //             child: Padding(

          //               padding: const EdgeInsets.all(8.0),
          //               child: Text(
          //                 '${ DateFormat("dd-mm-yy").format(ts.toDate())}',
          //                 textAlign: TextAlign.center,
          //               )

          //             ),



          //           )


          //         ),



          //       );
          //     },
          //     itemBuilder: (context, element) {
          //       return chatMessageTile(element.data()["message"], myUsername==element.data()["sendBy"], element.data()["ts"]);

          //     },





          // )




           : Center(child: CircularProgressIndicator());
      },
    );
  }

  getAndSetMessage()async{
    messageStream = await getChatroomMessage(chatroomID);
    setState(() {});
  }

  dothisonLaunch()async{
    await getInformation();
    getAndSetMessage();
  }
  @override
  void initState(){
    dothisonLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:darktheme,
      appBar: AppBar(
        backgroundColor: darkblue,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(),
            CircleAvatar(backgroundImage: NetworkImage(widget.profileURL),
            ),
            SizedBox(width: 20.0,),
            Text(widget.chatWithUsername,style: TextStyle(fontSize: 16),)
          ],
        ),
        ),
        body:Column(
          children: [
            Expanded(
              child: chatMessages()
              ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 342,
                  color:Color(0xFF087949).withOpacity(0.08)
                  )
                  ],
                ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child:Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.5),
                        decoration: BoxDecoration(color: darkblue.withOpacity(0.05),borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          children: [
                            Expanded(child: TextField(
                              // onChanged: (value){
                              //   addMessage(false);
                              // },
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: "Type some text",
                                border: InputBorder.none
                              ),
                              )
                              ),
                              GestureDetector(
                                onTap: (){
                                  addMessage();
                                },
                                child: Icon(Icons.send)
                                )
                          ],
                        ),
                      )
                      )
                  ],
                ),
                ),
            )
          ],
          ) ,
    );
  }
}