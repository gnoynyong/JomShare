import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
  
class OfferCarPool extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    final appTitle = 'Offer Pool';  
    // return MaterialApp(  
    //   title: appTitle,  
      return Scaffold(  
          appBar: AppBar(
            title: Text("Offer Pool"),
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
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();
  TextEditingController dateinput = TextEditingController();
  String dropdownValue = '1 Seat'; 
  @override  
  Widget build(BuildContext context) {  
    // Build a Form widget using the _formKey created above.  
    return Form(  
      key: _formKey,  
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.circle,color: Colors.green,),  
                        hintText: 'Enter Pick Up Location',  
                        labelText: 'Pick Up Location',
                      ),
                    ),
                    ),
                    Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.location_on,color: Colors.red,),  
                        hintText: 'Enter Drop Location',  
                        labelText: 'Drop Location',
                      ),
                    ),
                    ),
                ],
              ),
              ),
              Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Flexible(
                    child: DateTimeField(
                      decoration: InputDecoration(icon: Icon(Icons.event), hintText: 'Date Time',),
                      
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
                            initialTime:
                                TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                    ),
                    Flexible(
                      child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                      icon: Icon(Icons.people),
                      ),
                      hint: Text('Seat No.'),
                      items: <String>['1 Seat', '2 Seat','3 Seat', '4 Seat'].map((String value) {
                      return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                      }).toList(),
                    onChanged: (_) {},
                    ),
                      ),
                ],
              ),
              ),
              Flexible(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                      icon: Icon(Icons.directions_car),
                      ),
                      hint: Text('Car type'),
                      items: <String>['HatchBack', 'Sedan','SUV', '4×4'].map((String value) {
                      return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                      }).toList(),
                    onChanged: (_) {},
                    ),
                      ),
                   
                    
                    Flexible(
                      child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                      icon: Icon(Icons.merge_type),
                      ),
                      hint: Text('CarPool type'),
                      items: <String>['One-Time', 'Frequent'].map((String value) {
                      return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                      }).toList(),
                    onChanged: (_) {},
),
                      ),
                ],
              ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: new RaisedButton(  
                child: const Text('Offer Pool'),  
                onPressed: (){
                  Navigator.pop(context);
                },  
                            )
                      ),
                  ],
                )
          ],
        ),
        ),
    );  
  }  
}  