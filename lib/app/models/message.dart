import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timeStamps;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timeStamps,
  });

  factory Message.fromFirestore(Map<String, dynamic> data) {
    return Message(
        senderId: data['senderId'],
        senderEmail: data['senderEmail'],
        receiverId: data['receiverId'],
        message: data['message'],
        timeStamps: data['timeStamp']);
  }

  // factory Message.fromFirestore(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   return Message(
  //       senderId: data['senderId'],
  //       senderEmail: data['senderEmail'],
  //       receiverId: data['receiverId'],
  //       message: data['message'],
  //       timeStamps: data['timeStamp']);
  // }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timeStamp': timeStamps,
    };
  }
}
