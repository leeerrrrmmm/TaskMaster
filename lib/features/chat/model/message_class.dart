import 'package:cloud_firestore/cloud_firestore.dart';

///
class MessageClass {
  ///
  final String senderId;

  ///
  final String senderEmail;

  ///
  final String receiveId;

  ///
  final String message;

  ///
  final Timestamp timestamp;

  ///
  const MessageClass({
    required this.senderId,
    required this.senderEmail,
    required this.receiveId,
    required this.message,
    required this.timestamp,
    // required this.currentName,
    // required this.receiverName,
  });

  /// convert to Json
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiveId': receiveId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
