import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jomshare/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jomshare/screens/user%20authentication/license.dart';
import 'package:image_cropper/image_cropper.dart';
class createProfile extends StatefulWidget {


  @override
  _createProfileState createState() => _createProfileState();
}

class _createProfileState extends State<createProfile> {
  File ?_selectedFile;
  bool  _inprocess=true;
  bool _oriImage=true;
  final GlobalKey<FormState> _profileform = GlobalKey<FormState>();

 final TextEditingController _name = TextEditingController();
  final TextEditingController _icno = TextEditingController();
   final TextEditingController _age = TextEditingController();
    final TextEditingController _phone = TextEditingController();
     final TextEditingController _address = TextEditingController();
      final TextEditingController _occupation = TextEditingController();
bool ?L1,L2,L3,L4,L5;

String ?_gender='Male';
String ?validate (String ?value)
{
    if (value!.isEmpty)
  {
    return "The spaces cannot be empty";
  }

}
  Widget build(BuildContext context) {
    final arguments=ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
       backgroundColor: primaryColor,
    appBar: AppBar(
      centerTitle: true,
      title: Text('Create Your Profile',),
      elevation: 0,
      backgroundColor: lightpp,
      leading: IconButton(
        onPressed:(){
          Navigator.pop(context);
        }
      , icon: Icon(Icons.arrow_back_ios_new
      ,color: Colors.white,)),

    ),
    body: Padding(padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20)
    ,
    child: Form(
      key: _profileform,
      child: SingleChildScrollView(
        child: Column(


        children: [
          avatar(),
          SizedBox(height: 20,),
          TextFormField(
            controller: _name,
             keyboardType: TextInputType.name,
            validator: validate,

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey
              ),

              hintText: 'Name',
              prefixIcon: Icon(Icons.person
              ,size: 30,color: Colors.black),
              focusedBorder:OutlineInputBorder(


                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          enabledBorder:OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          errorBorder: OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.red,width: 1)
                          )
            ),

          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: _icno,
            validator: (value)
            {
              if (value!.isEmpty)
              {
                return "IC Number cannot be empty";
              }
                String pattern = r'^[0-9]{6}-[0-9]{2}-[0-9]{4}$';
              RegExp regExp = new RegExp(pattern);
              if (!regExp.hasMatch(value))
              {
                return "Invalid IC Number Format";
              }
            },

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              hintText: 'IC Number (XXXXXX-XX-XXXX)',
              prefixIcon: Icon(Icons.person
              ,size: 30,color: Colors.black),
              focusedBorder:OutlineInputBorder(


                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          enabledBorder:OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          errorBorder: OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.red,width: 1)
                          )
            ),

          ),SizedBox(height: 10,),
          Container(

            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue,width: 1)

              ,
              color: Colors.white,

            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: [

                  Icon(Icons.male,size: 30,),
                  SizedBox(width: 8,),
                  Text('Gender',style: TextStyle(fontSize:15,color:Colors.black,fontWeight: FontWeight.bold)),
                  SizedBox(width: 20,),
                  DropdownButton(
                    value:_gender,
                    items: [
                      DropdownMenuItem(child: Text('Male',style: TextStyle(fontSize: 20),),value: 'Male',),
                      DropdownMenuItem(child: Text('Female',style: TextStyle(fontSize: 20)),value: 'Female',),
                    ],
                    onChanged: (String ?value){
                      setState(() {
                        _gender=value;
                      });
                    },
                  )

                ],
              ),
            ),
          ),
           SizedBox(height: 10,),
          TextFormField(
            controller: _age,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(
              decimal: false,
              signed: false,

            ),
            validator: (value){
              if (value!.isEmpty)
              {
                return "Age cannot be empty";
              }
              if (int.parse(value)<=5||int.parse(value)>120)
              {
                return "Invalid age. Max age: 120 & Min age:5";
              }
            },

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              hintText: 'Age',
              prefixIcon: Icon(Icons.calendar_today
              ,size: 30,color: Colors.black),
              focusedBorder:OutlineInputBorder(


                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          enabledBorder:OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          errorBorder: OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.red,width: 1)
                          )
            ),

          ),

          SizedBox(height: 10,),
          TextFormField(
            controller: _phone,
            keyboardType: TextInputType.phone,

            validator: (value)
            {
                if (value!.isEmpty)
  {
    return "Phone number cannot be empty";
  }
            String pattern = r'^01[0-9]{1}-[0-9]{7,8}$';
              RegExp regExp = new RegExp(pattern);
              if(!regExp.hasMatch(value))
              {
                  return 'Please enter valid mobile number';
              }

            },
            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              hintText: 'Phone Number (Start with 01X-)',
              prefixIcon: Icon(Icons.phone
              ,size: 30,color: Colors.black),
              focusedBorder:OutlineInputBorder(


                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          enabledBorder:OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          errorBorder: OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.red,width: 1)
                          )
            ),

          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: _address,
            keyboardType: TextInputType.multiline,
            validator: validate,

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              hintText: 'Address',
              prefixIcon: Icon(Icons.home
              ,size: 30,color: Colors.black),
              focusedBorder:OutlineInputBorder(


                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          enabledBorder:OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          errorBorder: OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.red,width: 1)
                          )
            ),

          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: _occupation,
             keyboardType: TextInputType.multiline,
            validator: validate,

            decoration: InputDecoration(
              filled: true,

              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              hintText: 'Occupation',
              prefixIcon: Icon(Icons.business
              ,size: 30,color: Colors.black),
              focusedBorder:OutlineInputBorder(


                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          enabledBorder:OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.blue,width: 1)
                          ),
                          errorBorder: OutlineInputBorder(

                            borderSide:BorderSide(color: Colors.red,width: 1)
                          )
            ),

          ),

          SizedBox(height: 20,),
           ElevatedButton(
                        style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        primary: Colors.blue[900]
    ),
                      onPressed: (){
                          if (_selectedFile!=null)
                          {
if(_profileform.currentState!.validate())
                          {

                              Navigator.pushNamed(context, '/drivingProfile'
                              ,arguments: {'email':arguments['email'],'pass':arguments['pass']
                              ,'name':_name.text,'ic':_icno.text,'gender':_gender,'age':_age.text
                              ,'phone':_phone.text,'address':_address.text,'occupation':_occupation.text
                              ,'picture':_selectedFile});
                          }
                          }
                          else
                          {
                            showAlert(context);

                          }


                      },
                      child: Text('Next',
                      style: TextStyle(
                        fontSize:20
                      ),
                      )),

        ],
      ),
    ),
    ))
    );
  }
void showAlert(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Incomplete Profile Picture'),
                content: Text("Please upload your profile picture before proceeding"),
                actions: [
                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
                ],
              ));
    }
getImage (ImageSource source) async
{
   final ImagePicker _picker = ImagePicker();
  XFile? image=await _picker.pickImage(source: source);
  if (image!=null)
  {
  File? cropped=await ImageCropper.cropImage(sourcePath: image.path
  ,aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1)
  ,compressQuality:100,
  cropStyle: CropStyle.circle,
  maxHeight: 700,
  maxWidth:700,
  compressFormat:ImageCompressFormat.jpg,
  androidUiSettings:AndroidUiSettings(
    toolbarColor: Colors.blue,
    toolbarTitle:"Profile Image Cropper",

    backgroundColor:Colors.white,
  )
  );
  this.setState(() {
    _selectedFile=cropped ;
    _oriImage=false;
    _inprocess=false;
  });
  }
  else
  {
    this.setState(() {
      _inprocess=false;
    });
  }

}
Widget getImageWidget ()
{
  if (_selectedFile==null)
  {
     return ClipOval(

       child: Image.asset('assets/image/avatar.jfif',fit: BoxFit.cover,scale: 1.3,)
     )
     ;
  }
  else
  {
    return ClipOval(
      child: Image.file(_selectedFile!,fit: BoxFit.cover,scale: 1.3,),
    );
  }
}
  Widget avatar ()
{
return Stack(
      children: [


          getImageWidget()
          ,
          Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
              onTap: (){
                showModalBottomSheet(
                  context: context,
                   builder: (BuildContext context)
                   {
                        return Container(
                       height: 80,
                       color: Colors.white,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Column(
                             children: [
                               IconButton(
                             onPressed: (){
                               getImage(ImageSource.camera);
                               Navigator.pop(context);

                             },
                              icon: Icon(Icons.camera_alt,)),
                              Text('Choose From Camera')
                             ],
                           )
                           ,
                                Column(
                             children: [
                               IconButton(
                             onPressed: (){
                               getImage(ImageSource.gallery);
                               Navigator.pop(context);

                             },
                              icon: Icon(Icons.file_copy)),
                              Text('Choose From Gallery')
                             ],
                           ),


                         ],

                       ));



                   }
                   );
              },
              child: Icon(
                  Icons.camera_alt,
                  color: Colors.teal,
                  size: 40,

              ),
            )
          ),
      ],

    );
}
}