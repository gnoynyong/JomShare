import 'package:flutter/material.dart';

class manageHome extends StatefulWidget {


  @override
  _manageHomeState createState() => _manageHomeState();
}

class _manageHomeState extends State<manageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Manage Carpools'),
        bottom: TabBar(
tabs: [
Tab(
text: 'Requested',
),
Tab(text: 'Offered',)
],
        ),
      ),
    );
  }
}