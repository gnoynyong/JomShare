// ignore_for_file: file_names

import 'dart:ffi';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/components/roundbutton.dart';
import 'package:jomshare/components/smallroundbutton.dart';
import 'package:jomshare/constants.dart';
import 'package:getwidget/getwidget.dart';
import 'package:jomshare/screens/findpool/FindCarPool.dart';
import 'package:jomshare/screens/offerpool/OfferCarPool.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:address_search_field/address_search_field.dart';
import 'package:jomshare/services/userdatabase.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:jomshare/services/carpooldatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
 LatLng _initialPositon=LatLng(3.140853,101.693207);

Future<LatLng> _getPosition() async {
  final Location location = Location();
  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) throw 'GPS service is disabled';
  }
  if (await location.hasPermission() == PermissionStatus.denied) {
    if (await location.requestPermission() != PermissionStatus.granted)
      throw 'No GPS permissions';
  }
  final LocationData data = await location.getLocation();
  return LatLng(data.latitude!, data.longitude!);
}

class Poolpage extends StatefulWidget {
  const Poolpage({ Key? key }) : super(key: key);

  @override
  _PoolpageState createState() => _PoolpageState();
}

class _PoolpageState extends State<Poolpage> {
  bool _isloading=false;
  List <dynamic> Repeated_Day=['MON','TUE','WED','THU','FRI','SAT','SUN',];
  String repatedDay="";
  var type,selectedDay;
  List<bool> _selections = [true, false];
  final format = DateFormat("yyyy-MM-dd HH:mm");
  late final GoogleMapController _controller;
  bool pickup_is_Tap=false;
  bool drop_is_Tap=false;
  String ?cartype,seat;
  TextEditingController plateno = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController DT = TextEditingController();
  TextEditingController OpickupCtrl = TextEditingController();

  TextEditingController OdropCtrl = TextEditingController();
  TextEditingController FpickupCtrl = TextEditingController();

  TextEditingController FdropCtrl = TextEditingController();

  final polylines = Set<Polyline>();

  final markers = Set<Marker>();
  late LatLng Offerpickup;
  late LatLng Offerdrop;
  late LatLng Findpickup;
  late LatLng Finddrop;

  final geoMethods = GeoMethods(
    /// [Get API key](https://developers.google.com/maps/documentation/embed/get-api-key)
    googleApiKey: 'AIzaSyDCiCFG1oGg-XSj_67K6UzsHNU5UP5AvZA',
    language: 'en',
    countryCode: 'MY',
  );

  String convert (List<dynamic> x)
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
    return GFMultiSelect(
      size: GFSize.SMALL,

        items: Repeated_Day,
        onSelect: (value) {
          selectedDay=value;
        },
        dropdownTitleTileText: 'Repeted Days',
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
  Widget frequent(){
    if (type=='One-Time'){return Center();}
    else if (type=='Frequent'){return SingleChildScrollView(
      child: Container(
        child: Row(
          children: [
            Icon(Icons.cached_rounded),
                               SizedBox(width: 10,),

            TextButton(
              child: Text('Select Repeated Days',style:TextStyle(fontSize: 15,color: Colors.blue), ),

              onPressed: ()
              {
                showModalBottomSheet(context: context,
                builder:(BuildContext context)
                {
                  return Container(
                    height: MediaQuery.of(context).size.height*0.6,
                    child: Column(
                      children: [



                        dropdown(),
                        SmallRoundButton(
                                text: "Confirm",
                                press: (){

                                  Navigator.pop(context);
                                  print(type);
                                },
                                bckcolor: darkblue,
                                textColor: Colors.white,
                                btnstyle: TextStyle(fontSize: 15.0)),



                      ],
                    ),
                  );
                }
                );
              },

            ),
          ],
        )
    ));}
    else {return Center();}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:<Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width,
              child:GoogleMap(
              compassEnabled: true,
              padding: EdgeInsets.fromLTRB(0, 50, 10, 0),

              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              rotateGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _initialPositon,
                zoom: 10.5,
              ),
              onMapCreated: (GoogleMapController controller) =>
                  _controller = controller,
              polylines: polylines,
              markers: markers,
            ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height*0.42,
              // width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(borderRadius:BorderRadius.only(topLeft: Radius.circular(24),topRight:Radius.circular(24)
              //  ),
              //  color: Colors.green
              //  ),
              child:
              Stack(
                children:[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.425,
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.only(topLeft: Radius.circular(24),topRight:Radius.circular(24)),
                  color: darkblue,
                  ) ,
                  child:
                  Container(
                     margin:EdgeInsets.fromLTRB(20, 0, 20, 245),
                     child: Align(
                        alignment: Alignment.center,
                        child: Container(


                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFF5579C6),
                          ),
                          child: ToggleButtons(
                            children: <Widget>[
                            Container(
                             width: MediaQuery.of(context).size.width*0.35,
                             child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.directions_car,size:20.0,color: darkblue,),SizedBox(width: 10.0) ,Text("Find Pool",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5,),)],),

                                               ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.35,
                             child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.people,size:20.0,color: darkblue,),SizedBox(width: 10.0) ,Text("Offer Pool",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5,),)],),
                                               ),
                                              ],
                                              borderRadius: BorderRadius.circular(50),
                                              renderBorder: false,
                                              color: Colors.white,
                                              selectedColor: Colors.black,
                                              fillColor: Colors.white,

            onPressed: (index) {
            setState(() {
              for (int i = 0; i < _selections.length; i++) {
                if(i==index){
                    _selections[i]=true;
              }
              else{
                  _selections[i]=false;
              }
              }
            });
          },
          isSelected: _selections,),
                        ),
                      )
                  ),
              ),
                _selections[0]==true?
                Container(
                  margin: EdgeInsets.only(top: 100.0),
                  height: MediaQuery.of(context).size.height*0.45,
                  decoration:BoxDecoration(
                  borderRadius:BorderRadius.only(topLeft: Radius.circular(24),topRight:Radius.circular(24)),
                  color: Colors.white,
                  ),
                  child: FindSearchBox()
                            ):Container(),
              _selections[1]==true?
                Container(
                  margin: EdgeInsets.only(top: 100.0),
                  height: MediaQuery.of(context).size.height*0.45,
                  decoration:BoxDecoration(
                  borderRadius:BorderRadius.only(topLeft: Radius.circular(24),topRight:Radius.circular(24)),
                  color: Colors.white,
                  ),
                  child: Container(

                  child:_isloading? Center(child: CircularProgressIndicator(

                  ),)
                    :OfferSearchBox(),

                ),
                            ):Container(),
                ],
                )

            ),
          ],
        ),
      ),

    );
  }

  Widget OfferSearchBox ()
  {

    return RouteSearchBox(
      originCtrl: OpickupCtrl,
      destinationCtrl: OdropCtrl,
      geoMethods: geoMethods,
      builder: (context, originBuilder, destinationBuilder,
                waypointBuilder, waypointsMgr, relocate, getDirections) {
              if (OpickupCtrl.text.isEmpty)
                relocate(AddressId.origin, _initialPositon.toCoords());
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: TextFormField(




                                  controller: OpickupCtrl,
                                  onTap: ()=>showDialog(context: context,
                                  builder:(context) {
                                    pickup_is_Tap=true;
                                    return originBuilder.buildDefault(
                              builder: AddressDialogBuilder(),
                              onDone: (address) {

                                return null;},
                            );
                                  }
                                  ),
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.circle,color: Colors.green,),
                                    hintText: 'Enter Pick Up Location',
                                    labelText: 'Pick Up Location',
                                  ),
                                ),
                                ),
                                Flexible(
                                child: TextFormField(

                                  controller: OdropCtrl,
                                  onTap: () => showDialog(
                            context: context,
                            builder: (context) => destinationBuilder.buildDefault(

                              builder: AddressDialogBuilder(),
                              onDone: (address) {

                                return null;},
                            ),
                          ),
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.location_on,color: Colors.red,),
                                    hintText: 'Enter Drop Location',
                                    labelText: 'Drop Location',
                                  ),
                                ),
                                ),
                            ],
                          ),
                          ),
                          Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Flexible(
                            child: DateTimeField(


                              controller: DT,
                      decoration: InputDecoration(icon: Icon(Icons.event), hintText: 'Date Time',),

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
                            initialTime:
                                TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                            ),
                            Flexible(
                              child: DropdownButtonFormField<String>(

                              decoration: InputDecoration(
                              icon: Icon(Icons.people),
                              ),
                              hint: Text('Seat No.'),
                              items: <String>['1 Seat', '2 Seat','3 Seat', '4 Seat','5 Seat','6 Seat'].map((String value) {
                              return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                              }).toList(),
                            onChanged: (value) {
                              setState(() {
                                seat=value;

                              });


                            },
                            ),
                              ),
                        ],
                      ),
                      ),

                          Flexible(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: DropdownButtonFormField<String>(

                              decoration: InputDecoration(
                              icon: Icon(Icons.directions_car),
                              ),
                              hint: Text('Car type'),
                              items: <String>['HatchBack', 'Sedan','SUV', '4×4'].map((String value) {
                              return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),

                            );
                              }).toList(),
                            onChanged: (value) {
                              setState(() {
                                cartype=value;
                              });

                            },
                            ),
                              ),



                            Flexible(
                              child: DropdownButtonFormField<String>(

                              decoration: InputDecoration(
                              icon: Icon(Icons.merge_type),
                              ),
                              hint: Text('CarPool type'),
                              items: <String>['One-Time', 'Frequent'].map((String value) {
                              return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                              }).toList(),
                            onChanged: (value) {
                            setState(() {
                                      type=value;
                                    });
                            },

        ),

                              ),
                        ],
                      ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Flexible(child: TextFormField(

                                controller: plateno,

                                decoration: InputDecoration(

                                  icon: Icon(Icons.directions_car),
                                  labelText: 'Plate No'

                                )

                              )),
                              Flexible(child: TextFormField(

                                controller: price,
                                keyboardType: TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal:true,
                                ),

                                decoration: InputDecoration(

                                  icon: Icon(Icons.attach_money),
                                  labelText: 'Price (RM)'

                                )

                              )),
                            ],
                          )
                        )
                        ,
                        SizedBox(height: 10,),


                          frequent()
                        ,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                               Flexible(
                              child: SmallRoundButton(
                                text: "Offer Pool",
                                press: () async{
                                  if (OpickupCtrl.text==''||OdropCtrl.text==''||DT.text==''||seat==null||cartype==null||type==null
                                  ||plateno.text==''||price.text=='')
                                  {


                                     showDialog(
                                            context: context,
                                           builder: (context) => AlertDialog(
                                                title: Text('Incomplete Fields'),
                                          content: Text("Please makesure all fields for offerring carpool are filled"),
                                         actions: [
                                              TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
                                                  ],
              ));

                                  }
                                  else{
                                    setState(() {
                                      _isloading=true;
                                    });
                                    if (type=='One-Time')
                                    {
                                      repatedDay="";



                                    }
                                    else
                                    {

                                      repatedDay=convert(selectedDay);
                                    }
                                    print(repatedDay);

                                  print(OpickupCtrl.text);
                                   try {
                              final result = await getDirections();
                              markers.clear();
                              polylines.clear();
                              Offerpickup= Marker(
                                    markerId: MarkerId('origin'),
                                    position: result.origin.coords!).position;
                              Offerdrop= Marker(
                                    markerId: MarkerId('dest'),
                                    position: result.destination.coords!).position;
                                    print('offerpickup:' );
                                    print(Offerpickup);
                                     print('droppickup:' );
                                    print(Offerdrop);
                              markers.addAll([
                                Marker(
                                    markerId: MarkerId('origin'),
                                    position: result.origin.coords!),
                                Marker(
                                    markerId: MarkerId('dest'),
                                    position: result.destination.coords!)
                              ]);
                              result.waypoints.asMap().forEach((key, value) =>
                                  markers.add(Marker(
                                      markerId: MarkerId('point$key'),
                                      position: value.coords!)));
                              polylines.add(Polyline(
                                polylineId: PolylineId('result'),
                                points: result.points,
                                color: Colors.blue,
                                width: 5,
                              ));
                              setState(() {});
                              await _controller.animateCamera(
                                  CameraUpdate.newLatLngBounds(
                                      result.bounds, 60.0));
                            } catch (e) {
                              print(e);
                            }
                              var currentuser  = FirebaseAuth.instance.currentUser;
                              var userid;

                              if(currentuser!=null){
                             userid = currentuser.uid;
                             CarpoolService temp=CarpoolService();
                             await temp.offerCarpool(OpickupCtrl.text, OdropCtrl.text, seat!, cartype!, type, plateno.text, price.text, Offerpickup, Offerdrop
                             ,DT.text,repatedDay).then((value)
                             {


                               print ('done');
                               setState(() {
                                 _isloading=false;
                               });

                             });
                             print ('yes');
                             String newcarpoolid=await temp.getCarpoolId();
                             UserDataBaseService user=UserDataBaseService(uid: userid);
                             user.addCarpoolToUser(newcarpoolid);


                            }


                                  }




                                },
                                bckcolor: darkblue,
                                textColor: Colors.white,
                                btnstyle: TextStyle(fontSize: 15.0)),
                              ),


                          ],
                        )

                ],
              );
                }
      );
  }


  Widget FindSearchBox ()
  {
    return RouteSearchBox(
      originCtrl: FpickupCtrl,
      destinationCtrl: FdropCtrl,
      geoMethods: geoMethods,
      builder: (context, originBuilder, destinationBuilder,
                waypointBuilder, waypointsMgr, relocate, getDirections) {
              if (FpickupCtrl.text.isEmpty)
                relocate(AddressId.origin, _initialPositon.toCoords());
              return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: TextField(


                                  controller: FpickupCtrl,
                                  onTap: ()=>showDialog(context: context,
                                  builder:(context) {
                                    pickup_is_Tap=true;
                                    return originBuilder.buildDefault(
                              builder: AddressDialogBuilder(),
                              onDone: (address) {

                                return null;},
                            );
                                  }
                                  ),
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.circle,color: Colors.green,),
                                    hintText: 'Enter Pick Up Location',
                                    labelText: 'Pick Up Location',
                                  ),
                                ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: TextFormField(
                                  controller: FdropCtrl,
                                  onTap: () => showDialog(
                            context: context,
                            builder: (context) => destinationBuilder.buildDefault(

                              builder: AddressDialogBuilder(),
                              onDone: (address) {

                                return null;},
                            ),
                          ),
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.location_on,color: Colors.red,),
                                    hintText: 'Enter Drop Location',
                                    labelText: 'Drop Location',
                                  ),
                                ),
                        ),

                        new Container(
                            padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                            child: new RaisedButton(
                child: const Text('Find Pool'),
                onPressed: () async{
                  if (FpickupCtrl.text==''||FdropCtrl.text=='')
                                  {

                                     showDialog(
                                            context: context,
                                           builder: (context) => AlertDialog(
                                                title: Text('Incomplete Fields'),
                                          content: Text("Please makesure all fields for finding carpool are filled"),
                                         actions: [
                                              TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
                                                  ],
              ));

                                  }
                    else
                    {


                                   try {
                              final result = await getDirections();
                              markers.clear();
                              polylines.clear();
                              Findpickup= Marker(
                                    markerId: MarkerId('origin'),
                                    position: result.origin.coords!).position;
                                  Finddrop= Marker(
                                    markerId: MarkerId('dest'),
                                    position: result.destination.coords!).position;
                                    print('findpickup:' );
                                    print(Findpickup);
                                     print('findpickup:' );
                                    print(Finddrop);
                              markers.addAll([
                                Marker(
                                    markerId: MarkerId('origin'),
                                    position: result.origin.coords!),
                                Marker(
                                    markerId: MarkerId('dest'),
                                    position: result.destination.coords!)
                              ]);
                              result.waypoints.asMap().forEach((key, value) =>
                                  markers.add(Marker(
                                      markerId: MarkerId('point$key'),
                                      position: value.coords!)));
                              polylines.add(Polyline(
                                polylineId: PolylineId('result'),
                                points: result.points,
                                color: Colors.blue,
                                width: 5,
                              ));
                              setState(() {});
                              await _controller.animateCamera(
                                  CameraUpdate.newLatLngBounds(
                                      result.bounds, 60.0));
                            } catch (e) {
                              print(e);
                            }
                    }


                },
                            )),
                      ],
                    );
                }
      );
  }
}
