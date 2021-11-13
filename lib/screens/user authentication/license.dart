import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
class license extends StatefulWidget {


  @override
  _licenseState createState() => _licenseState();
}

class _licenseState extends State<license> {
  @override
  Map <String,bool?> license={
  'A': false,
  'A1': false,
  'D': false,
  'DA': false,
  'GDL': false,
};
var tempLicense =[];
  void getCheckBoxItems ()
{
 license.forEach((key, value) {
      if(value == true)
      {
        tempLicense.add(key);
      }
  });
   tempLicense.clear();
}
  Widget build(BuildContext context) {
    return ListView(
        children: license.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            value: license[key],
            activeColor: Colors.pink,
            checkColor: Colors.white,
            onChanged: (bool ?value) {
              setState(() {
                license[key] = value;
              });
            },
          );
        }).toList(),);
  }
}