
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {


  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {

  var _enteredMessage='';

  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    //unselect keyboard ie keyboard goes down

    final user = FirebaseAuth.instance.currentUser;
    
    
    final userData = await FirebaseFirestore.instance.collection('users').
    doc(user!.uid).get();


    //add your message to the firebase firestore collection chat
    FirebaseFirestore.instance.collection('chat').add({
      'text' : _enteredMessage,
      'createdAt' : Timestamp.now(),
      'userId': user.uid,
      'username': userData['username']

    });

    //clear pre-existing text from the text field that u use to send messages
    _controller.clear();
  }

  //Text controller
  final _controller = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            //REMEMBER
            //textfield in a row causes error
            //listview in a column causes error
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Send a message....'
              ),

              onChanged: (value){

                setState(() {
                  _enteredMessage=value;
                });

              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.send
              ),
              onPressed: _enteredMessage.trim().isEmpty?null
                  : _sendMessage
          )
        ],
      ),
    );
  }
}
