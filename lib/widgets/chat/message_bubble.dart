import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//adding key is giving an error....why??

class MessageBubble extends StatelessWidget {

  MessageBubble({required this.message,required this.isMe,required this.username});
  final String message;
  final bool isMe;
  final String username;
  //final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe? Radius.circular(0): Radius.circular(12)

            ),
            color: isMe? Colors.grey[300]:Theme.of(context).accentColor,

          ),

          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4,horizontal:8),

          child: Column(
            crossAxisAlignment: isMe? CrossAxisAlignment.end :
            CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe? Colors.black:
                      Theme.of(context).primaryColor
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe? Colors.black:
                  Theme.of(context).primaryColor,

                ),
                textAlign: isMe? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
