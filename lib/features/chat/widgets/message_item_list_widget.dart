import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///
class MessageItemListWidget extends StatelessWidget {
  ///
  const MessageItemListWidget({
    ///
    required this.messages,

    ///
    required FirebaseAuth firebaseAuth,

    required String receiverName,

    ///
    super.key,
  }) : _firebaseAuth = firebaseAuth,
       _receiverName = receiverName;

  ///
  final List<QueryDocumentSnapshot<Object?>> messages;
  final FirebaseAuth _firebaseAuth;
  final String _receiverName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (_, index) {
          final message = messages[index];
          final isSender =
              message['senderId'] == _firebaseAuth.currentUser?.uid;

          return Column(
            children: [
              Align(
                alignment: isSender
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Text(
                  isSender
                      ? _firebaseAuth.currentUser?.displayName ?? ''
                      : _receiverName,
                ),
              ),
              Align(
                alignment: isSender
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: message['message'].toString().length > 20 ? 160 : 80,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSender ? Colors.amber : Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(message['message'].toString()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
