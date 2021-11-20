import 'package:flutter/material.dart';
import 'package:jomshare/screens/user%20authentication/createProfile.dart';
import 'package:jomshare/screens/user%20authentication/forgetpassword.dart';
import 'package:jomshare/screens/user%20authentication/license.dart';
import 'package:jomshare/screens/welcome/welcome_screen.dart';
import 'package:jomshare/screens/splash/splash.dart';
import 'package:jomshare/screens/home/home.dart';
import 'package:jomshare/screens/user authentication/login.dart';
import 'package:jomshare/screens/user authentication/register.dart';
import 'package:firebase_core/firebase_core.dart';





Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jom Share',
      debugShowCheckedModeBanner: false,
     initialRoute: '/',

routes: {
  '/': (context)=> splash(),
  '/login': (context)=> login(),
  '/register': (context) => signUpScreen(),
  '/home': (context)=>Home(),
  '/forgetpass': (context)=>forgetpassword(),
  '/register/createProfile': (context)=>createProfile(),
  '/drivingProfile': (context)=>license(),

});
  }
}
