class Usermodel{
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  
  Usermodel({ this.uid, this.email, this.firstName, this.secondName});

  // To Fetch data from the server

 factory Usermodel.fromMap(map){
   return Usermodel(
     uid: map['uid'],
     email: map['email'],
     firstName: map['firstName'],
     secondName: map['secondName'],
   );
 }

//  To send data to server
Map<String, dynamic> toMap(){
  return{
    'uid': uid,
    'email': email,
    'firstName': firstName,
    'secondName': secondName,
  };

}

}

