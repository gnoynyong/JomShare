// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:address_search_field/address_search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/Manage/Offer.dart';

class editoffer extends StatefulWidget {
  const editoffer({ Key? key, required this.eoffer}) : super(key: key);

  final Offer eoffer;

  @override
  _editofferState createState() => _editofferState();
}

class _editofferState extends State<editoffer> {
  
  String ?cartype;
  @override
  Widget build(BuildContext context) {

    final eoffer1=widget.eoffer;
    final String vtype=eoffer1.vehicletype;
    TextEditingController DT = TextEditingController(text: eoffer1.datetime);
    TextEditingController OpickupCtrl = TextEditingController(text: eoffer1.start);
    TextEditingController OdropCtrl = TextEditingController(text: eoffer1.destination);
    
    TextEditingController PlateNo = TextEditingController(text: eoffer1.plateNo);
    TextEditingController Price = TextEditingController(text: "RM "+eoffer1.price.toStringAsFixed(2));

    CollectionReference carpooldb =
        FirebaseFirestore.instance.collection("carpool");

    Future<void> updateCarpool() {
      return carpooldb.doc(eoffer1.offerpoolid).update({
        'Date Time': DT.text,
        'Pickup address': OpickupCtrl.text,
        'Drop address': OdropCtrl.text,
      }).then((value) => print("Carpool updated!"))
      .catchError((err)=>print("Failed: $err"));
    }

    var format = DateFormat("yyyy-MM-dd HH:mm");
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
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
          child: Column(
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
                        controller: OdropCtrl,
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
                        "Price :",
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
                            cartype=value;
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
      )),
    );
  }
}
