import 'package:chatapp/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final _auth = FirebaseAuth.instance;
  //get the firebaseAuth instance to use authentication methods

  //to display circular loading indicator
  var isLoading = false;

  //Function to submit user details to firebase
  void _submitAuthForm(
      String email,
      String password,
      String username,
      bool isLogin, //to check if we are there in the login page
      BuildContext ctx
      )async{

    //variable to store user credentials obtained as a result from authentication
    UserCredential authResult;
    try {
      //print("ENTERED TRY");
      //print(email);
      //print(password);
      //print(username);

      //start loading

      setState(() {
        isLoading = true;
      });

      //if we are in the login page we sign in with email and password
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email.trim(),
            password: password);
      }

      //if we are in the sign up page we create user with email and password
      else {
        //create user
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email.trim(),
            password: password);

        //each user has a unique id or uid
        //In the firestore realtime database, data is stored in collections
        //in the form of docs. After creating a user we add it into our firebase
        //collection 'users', the doc is named as the uid and in the doc we have
        //the fields username and password

        await FirebaseFirestore.instance.collection('users').
        doc(authResult.user!.uid).set({
          'username': username,
          'email': email.trim()
        });
      }


    }catch(err) {
      var message = 'An error occured please check credentials';


      print(message);


      //show error message in snakcbar
      Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ));

      //If we get an error we should not display the circular progress indicator
      //hence set isLoading = false
      setState(() {
        isLoading=false;
      });
    } catch(err){

      print("LAST CATCH");
      print(err);
    }



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm,isLoading)
    );
  }
}
