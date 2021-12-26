import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FeedbackRating{
  String userID,carpoolID,feedback,feedbackDocID="";
  double rating;
  FeedbackRating(
    {
      required this.userID,
      required this.carpoolID,
      required this.feedback,
      required this.rating

    }
  );
  Future  createFeedbackRating () async
  {

  await FirebaseFirestore.instance.collection("FeedbackRating").add(
    {
      'carpoolID': carpoolID,
      'userID':userID,
      'feedback':feedback,
      'rating':rating,
    }
  ).then((value) => {
    feedbackDocID=value.id
  });
  // getFeedbackDocID();

  }
//   Future<void> getFeedbackDocID()
//   async {
//      await FirebaseFirestore.instance.collection("FeedbackRating").get().then((value) =>
//     {
//       value.docs.forEach((element) {
//         if (element.data()["carpoolID"]==carpoolID&&element.data()["userID"]==userID)
//         {
// feedbackDocID=element.id;
//         }

//       })
//     }

//      );
//      print ("Feedback:"+feedbackDocID);


//   }


}