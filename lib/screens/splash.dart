import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login2/screens/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body: Container(
         decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
            Colors.purple,
            Color.fromARGB(255, 240, 244, 245),
            Color.fromARGB(255, 51, 239, 236)
             ], 
        begin: Alignment.topCenter, end: Alignment.bottomCenter)),
         child: Center(
           child: AnimatedSplashScreen(
             backgroundColor: Colors.transparent,
             splash: const Icon(Icons.android,
             size: 200,
             color: Color.fromARGB(255, 67, 65, 65),
             ),
             splashIconSize: 200,
             splashTransition: SplashTransition.scaleTransition,
             duration: 1600,
              nextScreen: Login(),
              ),
         ),
      ),
      

    ) );
    
  }
}