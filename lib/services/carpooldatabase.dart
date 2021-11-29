import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CarpoolService
{
  String docid='';

  CollectionReference carpool = FirebaseFirestore.instance.collection('carpool');



  Future <void> offerCarpool (String pickup,String drop, String seat, String cartype, String pooltype,String plateno, String price,
  LatLng pickupLocation, LatLng dropLocation,String DT,String selectedday) async
  {

    docid=carpool.doc().id;
    int seatno=int.parse(seat.substring(0,1));

    carpool.doc(docid).set(
      {
        'Pickup address':pickup,
        'Drop address': drop,
        'Seat': seatno,
        'Car type': cartype,
        'Pool type': pooltype,
        'Plate no': plateno,
        'Price': int.parse(price),
        'Pickup coor': GeoPoint(pickupLocation.latitude,pickupLocation.longitude),
        'Drop coor': GeoPoint(dropLocation.latitude,dropLocation.longitude),
        'Date Time': DT,
        'Repeated Day': selectedday,




      }

    ).then((value) => print("carpool Added"))
          .catchError((error) => print("Failed to add carpool: $error"));

  }
  String getCarpoolId()
  {
    return docid;

  }

  Future <void> deleteCarpool (String carpoolId) async
  {
    await carpool.doc(carpoolId).delete().whenComplete(() => print('Carpool is deleted'))
      .catchError((e) => print(e));
  }
  Future <void> updateCarpoolByOne (String field,var newvalue,String carpoolDocID) async
  {
    await carpool.doc(carpoolDocID).update(
      {
        '${field}': newvalue
      }
    );
  }
    Future <void> updateCarpoolForAll (String carpoolDocID,String pickup,String drop, String seat, String cartype, String pooltype,String plateno, String price,
  LatLng pickupLocation, LatLng dropLocation,String DT,String selectedday) async
  {
      int seatno=int.parse(seat.substring(0,1));
    await carpool.doc(carpoolDocID).update(
      {
         'Pickup address':pickup,
        'Drop address': drop,
        'Seat': seatno,
        'Car type': cartype,
        'Pool type': pooltype,
        'Plate no': plateno,
        'Price': int.parse(price),
        'Pickup coor': GeoPoint(pickupLocation.latitude,pickupLocation.longitude),
        'Drop coor': GeoPoint(dropLocation.latitude,dropLocation.longitude),
        'Date Time': DT,
        'Repeated Day': selectedday,
      }
    );
  }
  Future <DocumentSnapshot> readCarpool(String carpoolDocID )
  {
    return carpool.doc(carpoolDocID).get();
  }

}