import 'package:jomshare/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/services/userdatabase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class license extends StatefulWidget {


  @override
  _licenseState createState() => _licenseState();
}
enum option {Yes,No}
class _licenseState extends State<license> {
  @override
  List <dynamic> license=['A','A1','D','DA'];
  var selection;
  option ?LicenseOption=option.No;
  option ?CarOption=option.No;
  bool licenseResult=false;
  bool carResult=false;
  String licenseType="";
  String uid="";
  bool _isloading=false;
final GlobalKey<State> _keyLoader = new GlobalKey<State>();
final AuthService _auth = AuthService();
  Widget vehicleOption ()
  {
    if (LicenseOption==option.Yes)
    {
      return Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 20,),
     Text('Do you have vehicles?',style: TextStyle(fontSize:26,color:Colors.black,fontWeight: FontWeight.bold)),

       RadioListTile(
         title: Text('Yes'),
         value: option.Yes,
         groupValue: CarOption,
         onChanged: (option ?value)
         {
             setState(() {
               CarOption=value;
             });

         }
         ),
         RadioListTile(
         title: Text('No'),
         value: option.No,
         groupValue: CarOption,
         onChanged: (option ?value)
         {


         setState(() {
           CarOption=value;
         });

         }
         ),

        ],
      );
    }
    else
    {
      return Center();
    }
  }
  Widget boxheight ()
  {

    if (LicenseOption==option.No)
    {
      return SizedBox(height: 100,);
    }
    else
    {
      return SizedBox(height: 50,);
    }

  }
  Widget licenseList()
  {
    if (LicenseOption==option.Yes)
    {
 return Column(
   children: [
     SizedBox(height: 10,),
     Text('Please select the types of your driving license',style: TextStyle(fontSize:15,color:Colors.black,fontWeight: FontWeight.bold)),
     Container(
      child: GFMultiSelect(
        items: license,
        onSelect: ( value) {

          selection=value;

        },
        dropdownTitleTileText: 'Types of driving license',
        dropdownTitleTileColor: Colors.grey[200],
        dropdownTitleTileMargin: EdgeInsets.only(
            top: 22, left: 18, right: 18, bottom: 5),
        dropdownTitleTilePadding: EdgeInsets.all(10),
        dropdownUnderlineBorder: const BorderSide(
            color: Colors.transparent, width: 2),
        dropdownTitleTileBorder:
        Border.all(color: Colors.black, width: 1),
        dropdownTitleTileBorderRadius: BorderRadius.circular(5),
        expandedIcon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black54,
        ),
        collapsedIcon: const Icon(
          Icons.keyboard_arrow_up,
          color: Colors.black54,
        ),
        submitButton: Text('OK'),
        dropdownTitleTileTextStyle: const TextStyle(
            fontSize: 14, color: Colors.black54),
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.all(6),
        type: GFCheckboxType.basic,
        activeBgColor: Colors.green.withOpacity(0.5),

      ),
),
   ],
 );
    }
    else
    {
      return Center();
    }

  }

  Widget build(BuildContext context) {

    final arguments=ModalRoute.of(context)!.settings.arguments as Map;
    String email=arguments['email'];
    String pass=arguments['pass'];
  return Scaffold(
       backgroundColor: primaryColor,
    appBar: AppBar(
      centerTitle: true,
      title: Text('Driving Profile'),
      elevation: 0,
      backgroundColor: lightpp,
      leading: IconButton(
        onPressed:(){
          Navigator.pop(context);
        }
      , icon: Icon(Icons.arrow_back_ios_new
      ,color: Colors.white,)),

    ),
    body: _isloading?Center(
        child: CircularProgressIndicator(),
      ):SingleChildScrollView(
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

    SizedBox(height: 20,),
     Text('Do you have driving license?',style: TextStyle(fontSize:26,color:Colors.black,fontWeight: FontWeight.bold)),

       RadioListTile(
         title: Text('Yes'),
         value: option.Yes,
         groupValue: LicenseOption,
         onChanged: (option ?value)
         {
             setState(() {
               LicenseOption=value;
             });

         }
         ),
         RadioListTile(
         title: Text('No'),
         value: option.No,
         groupValue: LicenseOption,
         onChanged: (option ?value)
         {


         setState(() {
           LicenseOption=value;
         });

         }
         ),

        licenseList(),


        vehicleOption(),
        boxheight(),
        Center(
             child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
        ),
        primary: Colors.blue[900]
    ),
                        onPressed: () async {
                          setState(() {
                            _isloading=true;
                          });


                            LicenseOption==option.No?licenseResult=false:licenseResult=true;
                            dynamic result = await _auth.registerWithEmailAndPassword(arguments['email'],arguments['pass']);
                            licenseType="";

                            if (licenseResult)
                            {

                              for (int i=0;i<selection.length;i++)
                              {
                                licenseType=licenseType+"/"+selection[i].toString();

                              }
                            }


                            if (result==null)
                            {
                              showAlert(context);


                            }
                            else
                            {

                              File image=arguments['picture'];
                              dynamic result = await _auth.signInWithEmailAndPassword(arguments['email'],arguments['pass']);
                              final user=UserDataBaseService(uid:_auth.getUID() );


                            String url=await user.uploadImageToFirebase(context, image);
                            print(url);
                             await user.addUser(arguments['name'], arguments['ic'], arguments['gender'], arguments['age'], arguments['phone'], arguments['address'], arguments['occupation']
                              ,licenseResult,carResult,licenseType,url).then((value) {
                                setState(() {
                                  _isloading=false;
                                });


                              });



                              Navigator.pushNamed(context, '/login');




                            }





                        },
                        child: Text("Complete registration",
                        style: TextStyle(
                          fontSize:20
                        ),
                        )),
           ),





        ],
      ),),
    )
    );


  }
  void showAlert(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Registration Error'),
                content: Text("This email has been registered.Please try with other email"),
                actions: [
                  TextButton(onPressed: (){Navigator.pushReplacementNamed(context, '/login');;}, child: Text('Ok'))
                ],
              ));
    }
    static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
}
