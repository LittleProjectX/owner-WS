import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String name;
  final bool isMe;

  const MessageBubble(this.message, this.name, this.isMe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: Get.width * 2 / 3),
          decoration: BoxDecoration(
            color: isMe ? Colors.green[300] : Colors.blue[400],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe ? Colors.black : Colors.white,
                ),
              ),
              Text(
                message,
                maxLines: null,
                softWrap: true,
                style: TextStyle(color: isMe ? Colors.black : Colors.white),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
