// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:getwidget/getwidget.dart';

import 'package:address_search_field/address_search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';

import 'package:jomshare/model/carpool.dart';
import 'package:jomshare/screens/Manage/ViewOffer.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:address_search_field/address_search_field.dart';
import 'package:location/location.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';


class editoffer extends StatefulWidget {
  const editoffer({ Key? key, required this.eoffer}) : super(key: key);

  final CarpoolObject eoffer;


  @override
  _editofferState createState() => _editofferState();
}

class _editofferState extends State<editoffer> {
    List <dynamic> Repeated_Day=['MON','TUE','WED','THU','FRI','SAT','SUN',];
   late LatLng Offerpickup;
    String repatedDay="";
    var selectedDay;
  late LatLng Offerdrop;
  String cartype='';
  String pooltype='';
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();
 TextEditingController DT = TextEditingController();
    TextEditingController OpickupCtrl = TextEditingController( );
    TextEditingController OdropCtrl = TextEditingController();

    TextEditingController PlateNo = TextEditingController();
    TextEditingController Price = TextEditingController();
void initState()
{
  DT.text=widget.eoffer.datetime;
  OpickupCtrl.text=widget.eoffer.start;
  OdropCtrl.text=widget.eoffer.destination;
  PlateNo.text=widget.eoffer.plateNo;
  Price.text=widget.eoffer.price.toStringAsFixed(2);
}
  @override
  Widget build(BuildContext context) {

    LatLng _initialPositon=LatLng(3.140853,101.693207);
    CarpoolObject eoffer1=widget.eoffer;

    final String vtype=eoffer1.vehicletype;
    pooltype=eoffer1.type;



    GeoMethods geoMethod=GeoMethods(googleApiKey: 'AIzaSyDCiCFG1oGg-XSj_67K6UzsHNU5UP5AvZA', countryCode: 'MY', language: 'en');
TextEditingController location=TextEditingController();



  final geoMethods = GeoMethods(
    /// [Get API key](https://developers.google.com/maps/documentation/embed/get-api-key)
    googleApiKey: 'AIzaSyDCiCFG1oGg-XSj_67K6UzsHNU5UP5AvZA',
    language: 'en',
    countryCode: 'MY',
  );

    CollectionReference carpooldb =
        FirebaseFirestore.instance.collection("carpool");

    Future<void> updateCarpool() {
      if (selectedDay==null)
      {
        repatedDay=eoffer1.repeatedDay;
      }
      else
      {
         repatedDay=convertDaytoString(selectedDay);
      }

      print(repatedDay);
      double temprice=double.parse(Price.text);
      eoffer1.datetime=DT.text;
      eoffer1.start=OpickupCtrl.text;
      eoffer1.destination=OdropCtrl.text;
      eoffer1.plateNo=PlateNo.text;
      eoffer1.repeatedDay=repatedDay;
      if (cartype=='')
      {
        cartype=eoffer1.vehicletype;
      }
      else
      {
        eoffer1.vehicletype=cartype;
      }

      eoffer1.price=temprice;
      print(temprice);
      return carpooldb.doc(eoffer1.pooldocid).update({
        'Date Time': DT.text,
        'Pickup address': OpickupCtrl.text,
        'Drop address': OdropCtrl.text,
        'Plate no':PlateNo.text,
        'Car type':cartype,
        'Price': temprice,
        'Repeated Day': repatedDay,

      }).then((value) => print("Carpool updated!"))
      .catchError((err)=>print("Failed: $err"));
    }

    var format = DateFormat("yyyy-MM-dd HH:mm");
    print(Price);
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()
          {



            Navigator.pop(context);
          },

        ),
          title: const Text("Edit"),
          backgroundColor: lightpp),
      body: SingleChildScrollView(
          // margin: const EdgeInsets.all(10.0),
          // padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   border: Border.all(
          //     color: Colors.black12,
          //     width: 1,
          //   ),
          // ),
          child: RouteSearchBox(
      originCtrl: OpickupCtrl,
      destinationCtrl: OdropCtrl,
      geoMethods: geoMethods,
      builder: (context, originBuilder, destinationBuilder,
                waypointBuilder, waypointsMgr, relocate, getDirections) {
              if (OpickupCtrl.text.isEmpty)
                relocate(AddressId.origin, _initialPositon.toCoords());
              return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0 ),
          //   color: Colors.blueGrey[800],
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text("Passenger :" ,style: TextStyle(fontSize: 17.5, color: Colors.white.withOpacity(0.85))),
          //       ListView.builder(
          //         shrinkWrap: true, //another solution is use expanded to warp all listview.builder but will use entire screen
          //         padding: const EdgeInsets.all(10),
          //         itemCount: eoffer.pname.length,
          //         itemBuilder:(context,index)=>
          //         Container(
          //           margin: EdgeInsets.only(bottom: 15.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               CircleAvatar(
          //                 radius: 24,
          //                 backgroundImage: AssetImage(eoffer.pimage[index]),
          //               ),
          //               SizedBox(width: 10,),
          //               Text(eoffer.pname[index], style: TextStyle(fontSize: 17.5, color: Colors.white.withOpacity(0.85)) ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Date Time:",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: DateTimeField(


                    controller: DT,
                    decoration: InputDecoration(

                        border: OutlineInputBorder(),
                        constraints:
                            BoxConstraints(maxWidth: 200.0, maxHeight: 50.0)),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                ),

                 SizedBox(
                  height: 20.0,
                ),
                dropdowntitle(),
                dropdown(),



                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text(
                      "Starting Point:",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )
                  ],
                ),

                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(


                        onTap: () async
                        {
                           showDialog(
                            context: context,
                            builder: (context) => originBuilder.buildDefault(

                              builder: AddressDialogBuilder(),
                              onDone: (address) {

                                return null;},
                            ),
                          );



                        },
                        maxLines: null,
                        controller: OpickupCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter Pick Up Location',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text(
                      "Destination:",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        maxLines: null,
                        controller: OdropCtrl,
                        onTap: ()
                        {
                           showDialog(
                            context: context,
                            builder: (context) => destinationBuilder.buildDefault(

                              builder: AddressDialogBuilder(),
                              onDone: (address) {

                                return null;},
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Drop Location',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Vehicle Type :",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Plate No :",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Price (RM) :",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        hint: Text('Car type'),
                        items: <String>['HatchBack', 'Sedan','SUV', '4×4'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        value: vtype,
                        onChanged: (value) {


                          setState(() {


                            cartype=value!



                            ;
                          });
                        },
                      ),
                    ),

                    SizedBox(width: 10.0,),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: PlateNo,
                        decoration: InputDecoration(
                          hintText: 'Enter Plate No',
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        controller: Price,
                        decoration: InputDecoration(
                          hintText: 'Enter Price',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       flex: 1,
                //       child: Row(
                //         children: [
                //           Text("Contact: ", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey),),
                //           Text(eoffer.contact, style: TextStyle(fontSize: 17.5),),
                //         ],
                //       )
                //     ),
                //     Expanded(
                //       flex: 1,
                //       child:
                //         eoffer.type=="Frequent"
                //         ?
                //         Row(
                //           children: [
                //             Text("Frequent Day: ", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey),),
                //             Text(eoffer.repeatedDay, style: TextStyle(fontSize: 17.5),),
                //           ],
                //         )
                //         :
                //         Container(),
                //     ),
                //   ],
                // ),


                ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                          overlayColor: MaterialStateProperty.all(Colors.blue[400]),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        onPressed: () {

                          updateCarpool();
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> viewoffer(voffer: eoffer1)));
                        },
                        child: Wrap(
                          children: [
                            Text("Complete",style: TextStyle(fontSize: 16.0),),
                          ],
                        ),
                      ),
              ],
            ),
          )
        ],
      );

                 } ),
    ));
  }
  Widget dropdowntitle()
  {
    if (pooltype=="Frequent")
    {
      return  Row(
                  children: [
                    Text(
                      "Repeated Days: ",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )
                  ],
                );
    }
    else
    {
      return Center();
    }
  }
    String convertDaytoString (List<dynamic> x)
  {
    List<String> temp=[];
    for (int i=0;i<x.length;i++)
    {
      temp.add(x[i].toString());

    }
    temp.sort((a,b){
      return a.compareTo(b);
    });

    String stringReturn='';
    for (int m=0;m<temp.length;m++)
    {
      stringReturn=stringReturn+"/"+temp[m];
    }
    return stringReturn;

  }
  Widget dropdown ()
  {
    if (pooltype=="Frequent")
    {
return GFMultiSelect(
      selected: true,
      size: GFSize.SMALL,

        items: Repeated_Day,
        onSelect: (value) {
          selectedDay=value;
        },
        dropdownTitleTileText: 'Repeated Days',
        dropdownTitleTileColor: Colors.grey[200],
        dropdownTitleTileMargin: EdgeInsets.only(
            top: 22, left: 18, right: 18, bottom: 5),
        dropdownTitleTilePadding: EdgeInsets.all(5),
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
            fontSize: 15, color: Colors.black54),
        padding: const EdgeInsets.fromLTRB(10, 0.5, 10, 0.5),
        margin: const EdgeInsets.all(0.5),
        type: GFCheckboxType.basic,
        activeBgColor: Colors.green.withOpacity(0.6),


      );
    }
    else
    {
      return Center();
    }

  }

}
