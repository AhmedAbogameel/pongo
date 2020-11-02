import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_adoption/constants.dart';
import 'package:pet_adoption/core/models/user_model.dart';
import 'package:pet_adoption/views/chat/app_bar.dart';
import 'package:pet_adoption/views/chat/chat_background.dart';
import 'package:pet_adoption/views/chat/list_view.dart';
import 'package:pet_adoption/views/chat/send_message_button.dart';
import 'package:pet_adoption/widgets/text_field.dart';

class ChatView extends StatefulWidget {
  final UserModel user;
  ChatView(this.user);
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController messageController = TextEditingController();
  @override
  void dispose() {
    hideStatusBar();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatAppBar(context,widget.user),
      body: ChatBackground(
        child: Column(
          children: [
            MessagesList(widget.user.userId),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: inputField(
                      controller: messageController, hint: 'Send Message...'),
                ),
                SendMessageButton(messageController,widget.user.userId),
              ],
            ),
          ],
        ),
      ),
    );
  }
}