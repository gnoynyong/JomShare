import 'package:flutter/material.dart';
import 'package:jomshare/screens/Manage/manageHome.dart';
import 'package:jomshare/screens/user%20authentication/login.dart';
import 'package:jomshare/screens/user%20authentication/register.dart';
import 'package:jomshare/constants.dart';
class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
int _currentIndex = 0;
  final List _children = [login(),signUpScreen(),manageHome()];
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SingleChildScrollView(
        child: SizedBox(
          height: 60,
          child: Theme(
            data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: lightpp,

            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
            child: BottomNavigationBar(
              elevation: 0,

              onTap: (index){
                setState(() {
               _currentIndex = index;
             });
              }, // new
             currentIndex: _currentIndex,

             items: [
               BottomNavigationBarItem(
                 icon: Icon(Icons.search,color: Colors.white,),
                 title: Text('Find Carpool',style: TextStyle(color: Colors.white)),
               ),
               BottomNavigationBarItem(
                 icon:  Icon(Icons.local_taxi,color: Colors.white),
                 title: Text('Offer Carpool',style: TextStyle(color: Colors.white)),
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.navigation_outlined,color: Colors.white),
                 title: Text('Manage carpools',style: TextStyle(color: Colors.white))
               ),

               BottomNavigationBarItem(
                 icon: Icon(Icons.more_vert , color: Colors.white),
                 title: Text('More',style: TextStyle(color: Colors.white,))
               )
             ],
               ),
          ),
        ),
      ),
    );
  }
}