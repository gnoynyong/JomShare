
import 'package:jomshare/screens/user%20authentication/license.dart';

class CUser
{
  final String uid;


  CUser({
    required this.uid,
  });


}

class CUserData
{
  String uid,name,icNo,gender,phone,occupation;
  bool license;
  String licenseType;
  double averageRating=0;
  List offered=[];

  CUserData({
    required this.uid,
    required this.name,
    required this.icNo,
    required this.gender,
    required this.phone,
    required this.occupation,
    required this.license,
    required this.licenseType
  });





}