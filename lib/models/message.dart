import 'package:scholar_chat/widget/constant.dart';

class Message {
  final String message;
  final String id;
  final String time;

  final String image;

  Message(this.message, this.id, this.time, this.image);

  factory Message.formJson(jsonData) {
    return Message(
      jsonData[kMessage] ?? '',
      jsonData['id'] ?? '',
      jsonData['message_time'] ?? '',
      jsonData['image'] ?? '',
    );
  }
}
