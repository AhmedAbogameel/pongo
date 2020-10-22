import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/keywords/firestore.dart';
import 'package:pet_adoption/widgets/text_field.dart';

class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  String user1 = 'Abogameel';
  String user2 = 'Dagla';
  String uid1 = 'a';
  String uid2 = 'aaa';

  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: sizeFromWidth(context, 1.3),
                  child: inputField(
                      controller: messageController, hint: 'Send Message...')),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 35,
                color: Colors.grey.withOpacity(0.2),
                onPressed: () {
                  if (messageController.text.isNotEmpty) {
                    FirebaseFirestore.instance
                        .collection('${FirestoreKeyWords.chats}/a/aaa')
                        .add({
                      FirestoreKeyWords.text: messageController.text,
                      FirestoreKeyWords.sentAt: Timestamp.now(),
                      FirestoreKeyWords.userName: user1,
                      FirestoreKeyWords.userId: user1,
                    });
                    FirebaseFirestore.instance
                        .collection('${FirestoreKeyWords.chats}/aaa/a')
                        .add({
                      FirestoreKeyWords.text: messageController.text,
                      FirestoreKeyWords.sentAt: Timestamp.now(),
                      FirestoreKeyWords.userName: user1,
                      FirestoreKeyWords.userId: user1,
                    });
                    messageController.clear();
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 35,
                color: Colors.amber,
                onPressed: () {
                  if (messageController.text.isNotEmpty) {
                    FirebaseFirestore.instance
                        .collection('${FirestoreKeyWords.chats}/aaa/a')
                        .add({
                      FirestoreKeyWords.text: messageController.text,
                      FirestoreKeyWords.sentAt: Timestamp.now(),
                      FirestoreKeyWords.userName: user2,
                      FirestoreKeyWords.userId: user2,
                    });
                    FirebaseFirestore.instance
                        .collection('${FirestoreKeyWords.chats}/a/aaa')
                        .add({
                      FirestoreKeyWords.text: messageController.text,
                      FirestoreKeyWords.sentAt: Timestamp.now(),
                      FirestoreKeyWords.userName: user2,
                      FirestoreKeyWords.userId: user2,
                    });
                    messageController.clear();
                  }
                },
              ),
            ],
          ),
          Expanded(child: Messages()),
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  String user1 = 'Abogameel';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('${FirestoreKeyWords.chats}/a/aaa')
          .orderBy('sentAt', descending: true)
          .snapshots(),
      builder: (_, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting)
          return Center(
            child: CupertinoActivityIndicator(),
          );
        final List docs = snapShot.data.docs;
        return ListView.builder(
          itemCount: docs.length,
          reverse: true,
          itemBuilder: (_, listIndex) => MessageBubble(
            isMe: docs[listIndex][FirestoreKeyWords.userName] == user1,
            key: ValueKey(docs[listIndex][FirestoreKeyWords.userId]),
            message: docs[listIndex][FirestoreKeyWords.text],
            userName: docs[listIndex][FirestoreKeyWords.userName],
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String userName;
  final Key key;

  const MessageBubble({this.isMe, this.message, this.userName, this.key});
  @override
  Widget build(BuildContext context) {
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
              Text(
                userName,
                style:
                    TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
              ),
              Text(message,style: TextStyle(fontSize: 25),),
            ],
          ),
          decoration: BoxDecoration(
              color: isMe
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.amber.withOpacity(0.7),
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
/*

FirebaseFirestore.instance
              .collection('chats/4z45UgN5ODveH8sre7Ml/messages')
              .snapshots()
              .listen((event) {
            event.docs.forEach((element)=> print(element['text']));
          });

 */