import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_master/features/chat/services/chat_service.dart';
import 'package:task_master/features/chat/widgets/message_item.dart';

///
class MessageItemListWidget extends StatelessWidget {
  ///
  final String senderId;

  ///
  final String receiverId;

  ///
  final String receiverName;

  ///
  final ChatService chatService;

  ///
  final void Function(String messageId, String messageText) onEditSelected;

  ///
  final bool isEditing;

  ///
  final String? editingMessageId;

  ///
  final VoidCallback cancelEditing;

  ///
  const MessageItemListWidget({
    required this.senderId,
    required this.receiverId,
    required this.receiverName,
    required this.chatService,
    required this.onEditSelected,
    required this.isEditing,
    required this.editingMessageId,
    required this.cancelEditing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chatService.fetchMessages(senderId, receiverId),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }
        final messages = snapshot.data?.docs ?? [];
        if (messages.isEmpty) {
          return const Center(child: Text("No messages"));
        }

        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (_, index) {
            final message = messages[index];
            final isSender = message['senderId'] == senderId;

            return MessageItem(
              message: message,
              isSender: isSender,
              senderName: isSender ? 'You' : receiverName,
              chatService: chatService,
              senderId: senderId,
              receiverId: receiverId,
              onEditSelected: onEditSelected,
              isEditing: isEditing,
              editingMessageId: editingMessageId,
              cancelEditing: cancelEditing,
            );
          },
        );
      },
    );
  }
}
