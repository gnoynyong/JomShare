// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jomshare/screens/Manage/ViewOffer.dart';

import 'Offer.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key? key,
    required this.offer,
    required this.press,
  }) : super(key: key);

  final Offer offer;
  final VoidCallback press;

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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              offer.datetime,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            // SizedBox(height: 3.0),
            // Row(
            //   children: [
            //     Icon(Icons.date_range),
            //     SizedBox(width: 10.0),
            //     Text(
            //       offer.date,
            //       style: TextStyle(color: Colors.black87),
            //     ),
            //   ],
            // ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Icon(Icons.airport_shuttle),
                SizedBox(width: 15.0),
                Text(offer.start)
              ],
            ),
            Icon(Icons.more_vert),
            Row(
              children: [
                Icon(Icons.arrow_downward),
                SizedBox(width: 15.0),
                Text(offer.destination),
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
