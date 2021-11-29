import 'package:flutter/material.dart';
import 'Passenger.dart';

class PassengerCard extends StatelessWidget {
  final Passenger psg;
  const PassengerCard({
     Key? key,
     required this.psg
     }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0, vertical:15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
               backgroundImage: AssetImage(psg.image),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(psg.name),
            (psg.isAccepted==true)
            ?
            Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  TextButton(
                    child: Text("Accept"),
                    style: TextButton.styleFrom(primary: Colors.white,backgroundColor: Colors.blue[300],),
                    onPressed: (){},
                    ),
                  SizedBox(width: 8.0,),
                  TextButton(
                    child:Text("Reject"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red
                    ),
                    onPressed: (){},
                    )
                ],
              ),
            )
            :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child:Text("Accepted",style: TextStyle(color: Colors.black54,fontSize: 18.0),) ,
              )
          ],
        ),
        ),
    );
  }
}