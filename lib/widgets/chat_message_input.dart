import 'package:flutter/material.dart';

class ChatMessageInput extends StatefulWidget {
  final TextEditingController textController;
  const ChatMessageInput({super.key, required this.textController});

  @override
  State<StatefulWidget> createState() => ChatMessageInputState();
}

class ChatMessageInputState extends State<ChatMessageInput> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: widget.textController,
        decoration: const InputDecoration(
          hintText: "Type a message...",
          border: InputBorder.none,
        ),
      ),
    );
  }
}