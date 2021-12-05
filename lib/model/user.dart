
import 'package:jomshare/screens/user%20authentication/license.dart';

class CUser
{
  final String uid;


  CUser({
    required this.uid,
  });


}

class UserData
{
  String uid="",name="",icNo="",gender="",phone="",occupation="",address="",imageurl="";
  bool license=false,haveCar=false;
  String licenseType="";
  double averageRating=0;
  int age=0;
  UserData();

  UserData.set({
    required this.uid,
    required this.name,
    required this.icNo,
    required this.gender,
    required this.phone,
    required this.occupation,
    required this.license,
    required this.licenseType,
    required this.address,
    required this.imageurl,
    required this.haveCar,
    required this.age,
  });





}