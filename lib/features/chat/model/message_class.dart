import 'package:cloud_firestore/cloud_firestore.dart';

///
class MessageClass {
  ///
  final String senderId;

  ///
  final String senderEmail;

  ///
  final String messageId;

  ///
  final String receiveId;

  ///
  final String message;

  ///
  final Timestamp timestamp;

  ///
  MessageClass({
    required this.senderId,
    required this.senderEmail,
    required this.messageId,
    required this.receiveId,
    required this.message,
    required this.timestamp,
  });

  ///
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'messageId': messageId,
      'receiveId': receiveId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
