import 'package:flutter/material.dart';  
  
class FindCarPool extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    final appTitle = 'Offer Pool';  
    // return MaterialApp(  
    //   title: appTitle,  
      return Scaffold(  
          appBar: AppBar(
            title: Text("Find Pool"),
          ),
             body: MyCustomForm(),
        );
  }  
}  
// Create a Form widget.  
class MyCustomForm extends StatefulWidget {  
  @override  
  MyCustomFormState createState() {  
    return MyCustomFormState();  
  }  
}  
// Create a corresponding State class, which holds data related to the form.  
class MyCustomFormState extends State<MyCustomForm> {  
  // Create a global key that uniquely identifies the Form widget  
  // and allows validation of the form.  
  final _formKey = GlobalKey<FormState>();
  DateTime _dateandtime = DateTime.now();
  Future pickDate(BuildContext context) async{
    final newDate = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2021), 
      lastDate: DateTime(2022));
      if(newDate==null)return;
      setState(() {
        _dateandtime=newDate;
      });
  }
  
  @override  
  Widget build(BuildContext context) {  
    // Build a Form widget using the _formKey created above.  
    return Form(  
      key: _formKey,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: <Widget>[  
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(  
              decoration: const InputDecoration(  
                icon: const Icon(Icons.circle,color: Colors.green,),  
                hintText: 'Enter Pick Up Location',  
                labelText: 'Pick Up Locatioon',  
              ),  
            ),
          ),  
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(  
              decoration: const InputDecoration(  
                icon: const Icon(Icons.gps_fixed,color:Colors.red),  
                hintText: 'Enter Drop Location',  
                labelText: 'Drop Location',  
              ),
            ),
          ),  
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children:[ TextButton(
                child: Text("Pick a Date"),
                onPressed: (){
                 pickDate(context);
                },
                ),
                Text(_dateandtime.toString())
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
           ), 
          new Container(  
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),  
              child: new RaisedButton(  
                child: const Text('Offer Pool'),  
                onPressed: (){
                  Navigator.pop(context);
                },  
              )),  
        ],  
      ),  
    );  
  }  
}  