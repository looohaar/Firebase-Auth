import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login2/model/user_model.dart';
import 'package:login2/screens/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
final _formKey= GlobalKey<FormState>();
class _HomeState extends State<Home> {

  SizedBox seperator(double height){
     return SizedBox(
        height: height,
    );

  }
  User? user=FirebaseAuth.instance.currentUser;
  Usermodel loggedInUser= Usermodel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
    .collection("users")
    .doc( user!.uid)
    .get()
    .then((value){
      this.loggedInUser= Usermodel.fromMap(value.data());
      setState(() {
        
      });
    });
  }
   
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                
                      Colors.purple,
                      Color.fromARGB(255, 240, 244, 245),
                      Color.fromARGB(255, 51, 239, 236)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          ),

          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Padding(padding: EdgeInsets.all(35),
                child: Form(child:Column(
                  children: <Widget>[

                    SizedBox(
                      height: 200,
                      child: Image.asset("assets/logo1.png"),
                      
                    ),
                    seperator(25),
                    Text('Welcome!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromARGB(137, 43, 40, 40)),),
                    seperator(10),
                    Text("${loggedInUser.firstName} ${loggedInUser.secondName}",style: TextStyle(color: Color.fromARGB(255, 12, 12, 12),fontWeight: FontWeight.bold,fontSize: 15),),
                    // seperator(10),
                    
                     Text("${loggedInUser.email}",style: TextStyle(color: Color.fromARGB(255, 12, 12, 12),fontWeight: FontWeight.bold,fontSize: 15),),

                     ActionChip(label: Text("Logout"),
                      onPressed: (){
                        logout(context);

                      },
                      backgroundColor: Colors.redAccent,)


                    

                  ],
                )),),
              ),
            ),

          ),
        ),
      ),
    );
    
  }

  // logout function

  Future<void> logout(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
  }
}