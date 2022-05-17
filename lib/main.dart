import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login2/screens/home.dart';
import 'package:login2/screens/login.dart';
import 'package:login2/screens/signup.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:login2/screens/splash.dart';


Future<void>main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
    
  }
}
