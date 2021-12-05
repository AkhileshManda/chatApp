import 'package:chatapp/screens/auth_screen.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{

  //initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        errorColor: Colors.red,
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        )

      ),

      //stream builder gets a stream of information from firebase instance
      //it builds widgets based on the data that it gets
      home: StreamBuilder(

        //here stream listens to any changes in authentication
        //authStateChanges() notifies about users sign in state

        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context,userSnapshot){

          //if data received (snapshot) has some data, i.e there has been a
          //change in the auth state of the user...show main screen for this
          // app
          // it is ChatScreen()....if no change in auth state then stay in the
          //authentication screen

          if(userSnapshot.hasData){
            return ChatScreen();
          }

          return AuthScreen();

        },
      ),
    );
  }
}



