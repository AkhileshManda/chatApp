import 'package:chatapp/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //recieves a stream of information from firebase collection chat
    return FutureBuilder<User>(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {

        if(futureSnapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      return  StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('chat')
          .orderBy('createdAt',descending: true).
              snapshots(),
        //snapshots received here will be arranged in descending order based on
        //the time the message was sent

        builder: (ctx,chatSnapshot){
            //if we are still connecting to firebase ie we are waiting for
          // data to be received from firebase show a circular progress indicator
            if(chatSnapshot.connectionState== ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //store the List of messages ( more accurately a list of documents)
            //obtained from the snapshots passed to the builder method
            //by using the .data.docs of the snapshot property

            final chatDocs= chatSnapshot.data!.docs;

            return ListView.builder(

                  //start building from bottom to top
                  reverse: true,
                  itemCount: chatDocs.length,
                  //directly display text FOR NOW (changed wohooo)
                  itemBuilder: (ctx, index) =>
                      MessageBubble(
                        message: chatDocs[index]['text'],
                        isMe: chatDocs[index]['userId']==futureSnapshot.data!.uid,
                        username: chatDocs[index]['username'],

                        //to efficiently re-render and update the list
                        //key: ValueKey(chatDocs[index].documentID),
                      ),
                );
              }
            );
        },
      );

  }
}
