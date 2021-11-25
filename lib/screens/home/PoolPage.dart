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

class Poolpage extends StatefulWidget {
  const Poolpage({ Key? key }) : super(key: key);

  @override
  _PoolpageState createState() => _PoolpageState();
}

class _PoolpageState extends State<Poolpage> {
  List <dynamic> Repeated_Day=['MON','TUE','WED','THU','FRI','SAT','SUN',];
  String repatedDay="Repeated Days";
  var type;
  List<bool> _selections = [true, false];
  final format = DateFormat("yyyy-MM-dd HH:mm");


  Widget dropdown ()
  {
    return GFMultiSelect(
      size: GFSize.SMALL,

        items: Repeated_Day,
        onSelect: (value) {
          type=value;
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/map1.jpeg"),
                  fit: BoxFit.fill)

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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                icon: const Icon(Icons.circle,color: Colors.green,),
                hintText: 'Enter Pick Up Location',
                labelText: 'Pick Up Locatioon',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                icon: const Icon(Icons.location_on,color:Colors.red),
                hintText: 'Enter Drop Location',
                labelText: 'Drop Location',
                            ),
                          ),
                        ),
                        /*Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children:[ TextButton(

                child: Text("Pick a Date"),
                onPressed: (){},
                ),
                            ]
                          ),
                          // child: TextFormField(
                          //   decoration: const InputDecoration(
                          //   icon: const Icon(Icons.calendar_today, color: Colors.black,),
                          //   hintText: 'Enter Pick Up Date Time',
                          //   labelText: 'Date & Time',
                          //   ),
                          //  ),
                        ),
                         Padding(
                           padding: EdgeInsets.all(10.0),
                           child: TextFormField(
                            decoration: const InputDecoration(
                            icon: const Icon(Icons.car_rental,color: Colors.black,),
                            hintText: 'Enter Car Type',
                            labelText: 'Car Type',
                            ),
                           ),
                         ), */
                        new Container(
                            padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                            child: new RaisedButton(
                child: const Text('Find Pool'),
                onPressed: (){
                  Navigator.pop(context);
                },
                            )),
                      ],
                    ),
                            ):Container(),
              _selections[1]==true?
                Container(
                  margin: EdgeInsets.only(top: 100.0),
                  height: MediaQuery.of(context).size.height*0.45,
                  decoration:BoxDecoration(
                  borderRadius:BorderRadius.only(topLeft: Radius.circular(24),topRight:Radius.circular(24)),
                  color: Colors.white,
                  ),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.circle,color: Colors.green,),
                                hintText: 'Enter Pick Up Location',
                                labelText: 'Pick Up Location',
                              ),
                            ),
                            ),
                            Flexible(
                            child: TextFormField(
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
                            onChanged: (_) {},
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
                            onChanged: (_) {},
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
                        SizedBox(height: 10,),


                          frequent()
                        ,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: SmallRoundButton(
                                text: "Offer Pool",
                                press: (){},
                                bckcolor: darkblue,
                                textColor: Colors.white,
                                btnstyle: TextStyle(fontSize: 15.0)),
                              ),
                          ],
                        )
                  ],
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
}