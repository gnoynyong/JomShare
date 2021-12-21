import 'package:flutter/material.dart';
import 'package:jomshare/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:jomshare/screens/Manage/OfferedBody.dart';

import 'package:jomshare/screens/Manage/requestBody.dart';
class manageHome extends StatefulWidget {


  @override
  _manageHomeState createState() => _manageHomeState();
}

class _manageHomeState extends State<manageHome>with SingleTickerProviderStateMixin {
TabController ?_controller;
  int _selectedIndex = 0;
void initState() {
    _controller = new TabController(length: 2, vsync: this);

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
      // Do whatever you want based on the tab index
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(icon: Icon(Icons.cached_rounded),
          onPressed: ()
          {
            setState(() {

            });
          },)
          ],
          backgroundColor: darkblue,

          title: Text('Manage My Carpools') ,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _controller,
            labelColor: Colors.white,
            indicatorColor: background,
            tabs: [
              Tab(
                child:Text('Requested\nCarpools',style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
              ),
             Tab(
                child:Text('Offered\nCarpools',style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
        body: TabBarView(
        controller: _controller,
        children: <Widget>[
            requestBody(),
            OfferedBody(),

        ],
      ),
      ),
    );
  }
}