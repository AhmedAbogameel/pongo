import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        backgroundColor: kBGColor,
        iconTheme: IconThemeData(color: kAccentColor),
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (_,listIndex)=>
        Card()
      ),
    );
  }
}
