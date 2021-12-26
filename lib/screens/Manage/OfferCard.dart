// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jomshare/screens/Manage/ViewOffer.dart';

import 'package:jomshare/model/carpool.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key? key,
    required this.offer,
    required this.press,
  }) : super(key: key);

  final CarpoolObject
   offer;
  final VoidCallback press;
  Widget status()
  {
    Color color;
    String status;
    if (offer.poolstatus!=null&&offer.poolstatus=="complete")
    {
      color=Colors.green;
      status="completed";

    }
    else
    {
       color=Colors.blue;
      status="on-going";

    }
    return Container(
                       padding: EdgeInsets.fromLTRB(20, 10, 20, 10),


                       decoration: BoxDecoration(
                         color:color ,
                         borderRadius: BorderRadius.circular(20)


                       ),
                       child: Text(

                         status.toUpperCase(),
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),
                       ),
                     );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
              offer.datetime,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),status()
            ],),


            SizedBox(height: 15.0),
            Row(
              children: [
                Icon(Icons.airport_shuttle),
                SizedBox(width: 15.0),
                SizedBox(width: 200,
                child:  Text(offer.start),),
              ],
            ),
            Icon(Icons.more_vert),
            Row(
              children: [
                Icon(Icons.arrow_downward),
                SizedBox(width: 15.0),
                SizedBox(width: 200,
                child:  Text(offer.destination),),

                Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.grey),
                    overlayColor: MaterialStateProperty.all(Colors.blue[400]),
                  ),
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => viewoffer(voffer:offer)),
                    );
                  },
                  child: Text("View")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
