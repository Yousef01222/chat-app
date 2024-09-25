import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/widget/constant.dart';

class ChatBuble extends StatelessWidget {
  ChatBuble({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                message.message.contains("https://")
                    ? Image.network(
                        message.message,
                        height: 300,
                        width: 150,
                      )
                    : Text(
                        message.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                const SizedBox(height: 8),
                Text(
                  Constant().formatTime(date: message.time),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubleForFrind extends StatelessWidget {
  const ChatBubleForFrind({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.teal[800],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            message.message.contains("https://")
                ? Image.network(
                    message.message,
                    height: 300,
                    width: 150,
                  )
                : Text(
                    message.message,
                    style: const TextStyle(color: Colors.white),
                  ),
            const SizedBox(height: 8),
            Text(
              Constant().formatTime(date: message.time),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
