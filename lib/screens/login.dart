import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login2/screens/home.dart';
import 'package:login2/screens/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _SignupState();
}

class _SignupState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _auth= FirebaseAuth.instance;
  String? errorMessage;

  
  @override

  Widget build(BuildContext context) {
    final emailField = TextFormField(
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail_outline,
          color: Colors.white70,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 132, 128, 128),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    

            
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
        onSaved: (value) {
        emailController.text = value!;
      },

    );

    final TextFormField passwordField = new TextFormField(
      autofocus: false,
      obscureText: true,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
        // ignore: prefer_const_constructors
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 132, 128, 128),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    

        
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
        onSaved: (value) {
        passwordController.text = value!;
      },

    );
    SizedBox seperator(double height) {
      return SizedBox(
        height: height,
      );
    }

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        onPressed: () {
      signIn(emailController.text, passwordController.text);

        },
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.purple,
            Color.fromARGB(255, 240, 244, 245),
            Color.fromARGB(255, 51, 239, 236)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
               
                child: Padding(
                  padding: EdgeInsets.all(35),
                  child: Form(
                    key: _formKey,
                      child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        child: Image.asset("assets/logo1.png"),
                      ),
                      seperator(15),
                      emailField,
                      seperator(10),
                      passwordField,
                      seperator(15),
                      loginButton,
                      seperator(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 15),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          GestureDetector(
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,fontSize: 15,
                                 
                                  color: Colors.redAccent),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ),
        ),  
      ),
    );
  }

  void signIn(String email, String password) async{
    if(_formKey.currentState!.validate()){

      try {


        await _auth.signInWithEmailAndPassword(email: email, password: password).then((uid) => {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home())),
        

   
        } );
        
      }
      on FirebaseAuthException catch (error) {
        switch (error.code){

        
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
  // else{
  //   final snackBar = SnackBar(
  //           content: const Text('Yay! A SnackBar!'),
  //           action: SnackBarAction(
  //             label: 'Undo',
  //             onPressed: () {
  //               // Some code to undo the change.
  //             },
  //           ),
  //         );
  //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}
}
