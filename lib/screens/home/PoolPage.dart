import 'package:flutter/material.dart';
import 'package:jomshare/components/smallroundbutton.dart';
import 'package:jomshare/constants.dart';
import 'package:jomshare/screens/findpool/FindCarPool.dart';
import 'package:jomshare/screens/offerpool/OfferCarPool.dart';


import 'MapBox.dart';

class PoolPage extends StatefulWidget {
  const PoolPage({ Key? key }) : super(key: key);

  @override
  _PoolPageState createState() => _PoolPageState();
}

class _PoolPageState extends State<PoolPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MapBox(),
            PoolImageCase(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FindPoolButton(),
                OfferPoolButton(),
              ],
            )
            // Container(
            //   child: Padding(
            //     padding: EdgeInsets.all(16.0),
            //     child: SmallRoundButton(
            //       text: "Find Carpool", 
            //       press: (){}, 
            //       bckcolor: darkblue, 
            //       textColor: Colors.white),
            //   ),
            // ),
            // Container(
            //   child: Padding(
            //     padding: EdgeInsets.all(16.0),
            //     child: SmallRoundButton(
            //       text: "Offer Carpool", 
            //       press: (){}, 
            //       bckcolor: darkblue, 
            //       textColor: Colors.white),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class PoolImageCase extends StatelessWidget {
  const PoolImageCase({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.4,
          height: MediaQuery.of(context).size.height*0.2,
          decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/image/find.jpg"),fit: BoxFit.cover),
          boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0,3),
          ),],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.4,
          height: MediaQuery.of(context).size.height*0.2,
          decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/image/offer.jpg"),fit: BoxFit.cover),
          boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0,3),
          ),
          ],
          ),
        ),
      ],
    );
  }
}

class OfferPoolButton extends StatelessWidget {
  const OfferPoolButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            child: Padding(
    padding: EdgeInsets.all(9.0),
    child: SmallRoundButton(
      text: "Offer Carpool", 
      press: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=>OfferCarPool())
        );
      }, 
      bckcolor: darkblue, 
      textColor: Colors.white),
            ),
    );
  }
}

class FindPoolButton extends StatelessWidget {
  const FindPoolButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
               child: Padding(
              padding: EdgeInsets.all(9.0),
               child: SmallRoundButton(
    text: "Find Carpool", 
    press: (){
      Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=>FindCarPool())
        );
    }, 
    bckcolor: darkblue, 
    textColor: Colors.white),
            ),
              );
  }
}

