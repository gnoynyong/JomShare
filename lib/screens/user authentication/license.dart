import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:jomshare/constants.dart';
class license extends StatefulWidget {


  @override
  _licenseState createState() => _licenseState();
}
enum option {Yes,No}
class _licenseState extends State<license> {
  @override
  List <dynamic> license=['A','A1','D','DA'];
  List <dynamic>selection=[];
  option ?LicenseOption=option.No;
  option ?CarOption=option.No;

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
          selection.clear();
          selection.add(value);


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
  return Scaffold(
       backgroundColor: primaryColor,
    appBar: AppBar(
      centerTitle: true,
      title: Text('Driving Profile',),
      elevation: 0,
      backgroundColor: lightpp,
      leading: IconButton(
        onPressed:(){
          Navigator.pop(context);
        }
      , icon: Icon(Icons.arrow_back_ios_new
      ,color: Colors.white,)),

    ),
    body: SingleChildScrollView(
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
                        onPressed: (){
                            Navigator.pushNamed(context, '/login');


                        },
                        child: Text('Complete Registration',
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
}