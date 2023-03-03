import 'dart:io';

import 'package:are_you_shipping_me/widgets/text_fields/text_field_outlined.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.only(left: 14, right: 10),
          icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Jason K',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: ChatWidget(),
    );
  }
}

class ChatWidget extends StatelessWidget {
  ChatWidget({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                getSenderView(
                    ChatBubbleClipper3(
                        type: BubbleType.sendBubble, nipSize: 10),
                    context),
                getReceiverView(
                    ChatBubbleClipper3(
                        type: BubbleType.receiverBubble, nipSize: 10),
                    context),
                getSenderView(
                    ChatBubbleClipper3(
                        type: BubbleType.sendBubble, nipSize: 10),
                    context),
                getReceiverView(
                    ChatBubbleClipper3(
                        type: BubbleType.receiverBubble, nipSize: 10),
                    context),
                getSenderView(
                    ChatBubbleClipper3(
                        type: BubbleType.sendBubble, nipSize: 10),
                    context),
                getReceiverView(
                    ChatBubbleClipper3(
                        type: BubbleType.receiverBubble, nipSize: 10),
                    context),
                getSenderView(
                    ChatBubbleClipper3(
                        type: BubbleType.sendBubble, nipSize: 10),
                    context),
                getReceiverView(
                    ChatBubbleClipper3(
                        type: BubbleType.receiverBubble, nipSize: 10),
                    context),
                getSenderView(
                    ChatBubbleClipper3(
                        type: BubbleType.sendBubble, nipSize: 10),
                    context),
                getReceiverView(
                    ChatBubbleClipper3(
                        type: BubbleType.receiverBubble, nipSize: 10),
                    context),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          _editCommentField()
        ],
      ),
    );
  }

  getTitleText(String title) => Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      );

  getSenderView(CustomClipper clipper, BuildContext context) => ChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(top: 20),
        backGroundColor: Colors.black.withOpacity(0.9),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  getReceiverView(CustomClipper clipper, BuildContext context) => ChatBubble(
        clipper: clipper,
        backGroundColor: const Color(0xffE7E7ED),
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: const Text(
            "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );

  Widget _editCommentField() {
    return TextFieldOutlined(
      textEditingController: textEditingController,
      label: "Type here...",
      suffixIcon: sendIcon(),
      isRequiredField: false,
    );
  }

  Widget sendIcon() {
    return const Padding(
      padding: EdgeInsets.all(4.0),
      child: Icon(
        Icons.send,
        color: Colors.black,
        size: 25,
      ),
    );
  }
}
