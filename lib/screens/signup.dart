

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login2/model/user_model.dart';
import 'package:login2/screens/home.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

final _auth= FirebaseAuth.instance;
String? errorMessage;

   final _formKey= GlobalKey<FormState>();

   final firstnameController= new TextEditingController();
   final secondnameController= new TextEditingController();
   final emailController= new TextEditingController();
   final passwordController= new TextEditingController();
   final confirmpasswordController= new TextEditingController();

  @override
  Widget build(BuildContext context) {

//  first name

final firstName= TextFormField(

  autofocus: false,
  controller: firstnameController,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  cursorColor: Colors.white,
   style: TextStyle(color: Colors.white.withOpacity(0.9)),
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.person_outline, color:  Colors.white70,),
    contentPadding: EdgeInsets.fromLTRB(15, 20, 15, 20),
    hintText: "First Name",
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
    filled: true,
    fillColor: Color.fromARGB(255, 132, 128, 128),
    floatingLabelBehavior: FloatingLabelBehavior.never,

  ),

  onSaved: (value){
    firstnameController.text= value!;

  },
    validator: (value) {
        RegExp regex= new RegExp(r'^.{3,}$');
        if(value!.isEmpty){
          return " First Name Cannot Be Empty";
        }
        if(!regex.hasMatch(value)){
          return "Enter A Valid Name(Min. 3 Characters)";
        }
        // return "null";

      },

  
  
);

SizedBox seperator(double height){
  return SizedBox(
    height: height,
  );

}

//  secondname
final secondName= TextFormField(
  controller: secondnameController,
  autofocus: false,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  cursorColor: Colors.white,
   style: TextStyle(color: Colors.white.withOpacity(0.9)),
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.person_outline,color: Colors.white70,),
    contentPadding: EdgeInsets.fromLTRB(15, 20, 15, 20),
    hintText: " Second Name",
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
   fillColor: Color.fromARGB(255, 132, 128, 128),
    filled: true ,
    floatingLabelBehavior: FloatingLabelBehavior.never,
  
  ),

  onSaved: (value){
    secondnameController.text= value!;
  },
  validator: (value) {
       
        if(value!.isEmpty){
          return " Second Name Cannot Be Empty";
        }
        
        return null;

      },

);

// email

  final emailField= TextFormField(
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    autofocus: false,
    
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.mail_outline,color: Colors.white70,) ,
      contentPadding:  EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: "Email",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(width: 0,style: BorderStyle.none), ),
      filled: true,
      fillColor: Color.fromARGB(255, 132, 128, 128),
       floatingLabelBehavior: FloatingLabelBehavior.never,
      
      
    ),

    onSaved: (value){
      emailController.text= value!;

    },
    validator: (value) {
      if(value!.isEmpty){
        return ("Please Enter Your Email");

      }
      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
      {
             return ("Please Enter a Valid Email");
      }
      return null;

      },
  );

  // password
  
  final  TextFormField passwordField= new TextFormField(
    autofocus: false,
    obscureText: true,
     cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    controller: passwordController,
    keyboardType: TextInputType.visiblePassword,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.lock_outline,color: Colors.white70),
      // ignore: prefer_const_constructors
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: "Password",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(width: 0,style: BorderStyle.none), ),
      filled: true,
      fillColor: Color.fromARGB(255, 132, 128, 128),
       floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    onSaved: (value){
      passwordController.text=value!;
    },
      
      validator: (value) {
        RegExp regex= new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return "Please Enter Your Password";
        }
        if(!regex.hasMatch(value)){
          return "Enter A Valid Password(Min. 6 Characters)";
        }
        // return "null";

      },

  );

  // confirm password

  
  final  TextFormField confirmpasswordField= new TextFormField(
    autofocus: false,
    obscureText: true,
     cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    controller: confirmpasswordController,
    keyboardType: TextInputType.visiblePassword,
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.lock_outline,color: Colors.white70),
      // ignore: prefer_const_constructors
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: " Confirm Password",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(width: 0,style: BorderStyle.none), ),
      filled: true,
      fillColor: Color.fromARGB(255, 132, 128, 128),
       floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    onSaved: (value){
      confirmpasswordController.text=value!;
    },
      
      validator: (value){
        if (confirmpasswordController.text!= passwordController.text){
          return "Password Did Not Match";
        }
        return null;

      },

  );

  final signUpButton= Material(

    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: Colors.redAccent,
    child: MaterialButton(
      onPressed: (){
        signUp(emailController.text, passwordController.text);
      },
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      minWidth: MediaQuery.of(context).size.width,
      child: Text('SignUp',
      textAlign:TextAlign.center ,
      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold ,fontSize: 30),),
      ),
  );



    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
         appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 14, 14, 14)),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
       
        
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
                    Colors.purple,
                    Color.fromARGB(255, 240, 244, 245),
                    Color.fromARGB(255, 51, 239, 236)

            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,)
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Padding(padding: EdgeInsets.all(36),
                child: Form(
                  key: _formKey,
                  child: Column(
                  children: <Widget>[
                        
                       SizedBox(
                         height: 200,
                         child: Image.asset("assets/logo1.png")
                       ),
                    seperator(15),
                    firstName,
                    seperator(10),
                    secondName,
                    seperator(10),
                    emailField,
                    seperator(10),
                    passwordField,
                    seperator(10),
                    confirmpasswordField,
                    seperator(15),
                    signUpButton,



                  ],
                )),),
              ),
            ),
          ),
        ),

      )
    );
    
  }

void signUp(String email, String password)async{
  if ( _formKey.currentState!.validate()){
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {postDetailsToFirestore()})
      .catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });

    }

    on FirebaseAuthException catch (error){
      switch(error.code){

         case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened."; 

      }
      Fluttertoast.showToast(msg: errorMessage!);
      print(error.code);
    }
  }

 
}

  postDetailsToFirestore()async{
    // calling FireStore
    // calling user model
    // sending these values

    FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
    
    User? user = _auth.currentUser;
    Usermodel usermodel= Usermodel();

    // writing all values to the data base

    usermodel.email= user!.email;
    usermodel.uid= user.uid;
    usermodel.firstName= firstnameController.text;
    usermodel.secondName= secondnameController.text;

    await firebaseFirestore
    .collection('users')
    .doc(user.uid)
    .set(usermodel.toMap());

    Fluttertoast.showToast(msg: "Account Created Successfully");

    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context)=>Home()), (route) => false);

    
  }



}
