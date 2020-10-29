import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String userName;
  final Timestamp timestamp;
  final Key key;

  const MessageBubble({this.isMe, this.message, this.userName, this.timestamp, this.key});
  @override
  Widget build(BuildContext context) {
    final DateTime messageTime = timestamp.toDate();
    final String hour = messageTime.hour.toString().padLeft(2,'0');
    final String minute = messageTime.minute.toString().padLeft(2,'0');
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: sizeFromWidth(context, 1.7),
          margin: EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userName,
                    style:
                    TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
                  ),
                  Text('$hour:$minute',style: TextStyle(color: Colors.black54),),
                ],
              ),
              Text(message,style: TextStyle(fontSize: 25,color: isMe ? kAccentColor : kPrimaryColor),),
            ],
          ),
          decoration: BoxDecoration(
              color: isMe
                  ? kPrimaryColor.withOpacity(0.75)
                  : kAccentColor.withOpacity(0.75),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(15),
                bottomRight: !isMe ? Radius.circular(15) : Radius.circular(0),
              )),
        ),
      ],
    );
  }
}