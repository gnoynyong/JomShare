import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jomshare/screens/Manage/manageHome.dart';
import 'package:jomshare/screens/Profile/UserProfile.dart';
import 'package:jomshare/screens/contact/ChatPage.dart';
import 'package:jomshare/screens/home/Pool.dart';
import 'package:jomshare/screens/home/Poolpage.dart';
import 'package:jomshare/screens/offerpool/OfferCarPool.dart';
import 'package:jomshare/screens/user%20authentication/login.dart';
import 'package:jomshare/screens/user%20authentication/register.dart';
import 'package:jomshare/constants.dart';


class Home extends StatefulWidget {
  int index=0;

  Home()
  {

  }
  Home.set (int x)
  {
    index=x;
  }
  int getvalue()
  {
    return index;
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
int _currentIndex = 0;
  final List _children = [Poolpage(),manageHome(),ChatPage(),UserProfile()];

  Widget build(BuildContext context) {





    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _children.elementAt(_currentIndex),
        bottomNavigationBar: SingleChildScrollView(
          child: SizedBox(
            height: 60,
            child: Theme(
              data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.white,

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
                   icon: Icon(Icons.home,color: darkblue,),
                   title: Text('Home',style: TextStyle(color: darkblue)),
                 ),

                 BottomNavigationBarItem(
                   icon: Icon(Icons.navigation_outlined,color: darkblue),
                   title: Text('Trips',style: TextStyle(color: darkblue))
                 ),
                 BottomNavigationBarItem(
                   icon:  Icon(Icons.chat,color: darkblue),
                   title: Text('Chat',style: TextStyle(color: darkblue)),
                 ),
                 BottomNavigationBarItem(
                   icon: Icon(Icons.more_vert , color: darkblue),
                   title: Text('More',style: TextStyle(color: darkblue,))
                 )
               ],
                 ),
            ),
          ),
        ),
      ),
    );
  }
}