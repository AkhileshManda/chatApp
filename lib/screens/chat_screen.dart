
import 'package:chatapp/widgets/chat/messages.dart';
import 'package:chatapp/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



class ChatScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8,),
                        Text('Logout')
                      ],
                    ),
                  ),
                value: 'logout',


              )
            ],

            onChanged: (itemIdentifier){

              if(itemIdentifier=='logout'){
                FirebaseAuth.instance.signOut();
              }

            },

              )

        ],
      ),
      body: Container(
        
        child: Column(
          children: [
            //widget for displaying existing messages
            Expanded(child: Messages()),
            NewMessage()//widget for submitting messages
          ],
        ),

      ),




  );
  }
}
