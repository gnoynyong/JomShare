

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
class UserDataBaseService
{
  String uid;
  UserDataBaseService(
    {
      required this.uid
    }
  );
CollectionReference user = FirebaseFirestore.instance.collection('user');



  Future <void> addUser(String name,String ic,String gender,String age,String phone
  ,String address,String occupation,bool licenseOption,bool carOption,String license,String url)
   async {
  user.doc(uid).set(
{
      'name': name,
      'icNo':ic,
      'gender':gender,
      'age':int.parse(age),
      'phone':phone,
      'address':address,
      'occupation':occupation,
      'havelicense':licenseOption,
      'haveCar':carOption,
      'licenseType':license,
      'url': url,






    }
 ).then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));


  }
  static Future<UploadTask?> uploadFile(String destination, File file) async {


    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
  Future uploadImageToFirebase (BuildContext contex,File image) async {


     final fileName = basename(image.path);
    final destination = 'image/$fileName';

    UploadTask? task = await uploadFile(destination, image);




    final snapshot = await task!.whenComplete(() {});
    final urlDownload =  snapshot.ref.getDownloadURL();


    return urlDownload;






  }
  Future <void> deleteImageFromStorage (String url)
  async {
   await FirebaseStorage.instance.refFromURL(url).delete();
  }

  Future <void> addCarpoolToUser(String carpoolId) async
  {
    user.doc(uid).update(
      {
          'Offered carpools':FieldValue.arrayUnion([carpoolId]),
      }
    ).then((value) => print("Offer carpools added to user"))
          .catchError((error) => print("Failed to add carpool into user: $error"));


  }
  Future <void> addRequestCarpoolToUser(String carpoolId) async
  {
    user.doc(uid).update(
      {
          'Requested carpools':FieldValue.arrayUnion([carpoolId]),
      }
    ).then((value) => print("Request carpools added to user"))
          .catchError((error) => print("Failed to add request carpool into user: $error"));


  }

}