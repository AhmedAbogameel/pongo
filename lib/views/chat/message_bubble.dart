import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pet_adoption/widgets/pop_button.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String userName;
  final Timestamp timestamp;
  final Key key;
  LatLng _messageLatLng;
  Widget googleMap;
  MessageBubble({this.isMe, this.message, this.userName, this.timestamp, this.key});
  @override
  Widget build(BuildContext context) {
    if(message.contains('LatLng(')) {
     List msgListed = message.split('LatLng');
     msgListed = msgListed.join().split('(');
     msgListed = msgListed.join().split(')');
     msgListed = msgListed.join().split(',');
     _messageLatLng = LatLng(double.parse(msgListed[0]), double.parse(msgListed[1]));
     googleMap = GoogleMap(
       zoomControlsEnabled: false,
       initialCameraPosition: CameraPosition(target: _messageLatLng,zoom: 18),
       markers: {Marker(markerId: MarkerId('messagePosition'),position: _messageLatLng)},
     );
    }
    var sentAt = DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: _messageLatLng == null ? sizeFromWidth(context, 1.7) : sizeFromWidth(context, 1.2),
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
                  Text(
                    '$sentAt'
                    ,style: TextStyle(color: Colors.black54),),
                ],
              ),
              message.contains('LatLng(') && message.contains(',') && message.contains(')') ?
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  child: SizedBox(
                    height: 300,
                    child: ClipRRect(
                      borderRadius:  BorderRadius.circular(20),
                      child: AbsorbPointer(
                        absorbing: true,
                        child: googleMap,
                      ),
                    ),
                  ),
                  onTap: ()=> showCupertinoDialog(context: context, builder: (_)=> Material(
                    child: Stack(
                      children: [
                        googleMap,
                        Positioned(top: 10,left: 10,child: PopButton()),
                      ],
                    ),
                  )),
                ),
              )
                  : Text(message,style: TextStyle(fontSize: 17,color: isMe ? kAccentColor : kPrimaryColor),),
              if(_messageLatLng != null)
                Text('Tap for more options',style: TextStyle(color: isMe ? kAccentColor : kPrimaryColor),)
            ],
          ),
          decoration: BoxDecoration(
              color: isMe
                  ? kPrimaryColor.withOpacity(0.9)
                  : kAccentColor.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(15),
                bottomRight: !isMe ? Radius.circular(15) : Radius.circular(0),
              ),
          ),
        ),
      ],
    );
  }
}