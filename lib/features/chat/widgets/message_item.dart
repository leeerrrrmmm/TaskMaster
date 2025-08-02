import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_master/features/chat/services/chat_service.dart';

///
class MessageItem extends StatelessWidget {
  ///
  final QueryDocumentSnapshot message;

  ///
  final bool isSender;

  ///
  final String senderName;

  ///
  final ChatService chatService;

  ///
  final String senderId;

  ///
  final String receiverId;

  ///
  final void Function(String messageId, String messageText) onEditSelected;

  ///
  ///
  final bool isEditing;

  ///
  final String? editingMessageId;

  ///
  final VoidCallback cancelEditing;

  ///
  const MessageItem({
    required this.message,
    required this.isSender,
    required this.senderName,
    required this.chatService,
    required this.senderId,
    required this.receiverId,
    required this.onEditSelected,
    required this.isEditing,
    required this.editingMessageId,
    required this.cancelEditing,
    super.key,
  });

  Future<void> _showMenu(BuildContext context, Offset globalPosition) async {
    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        globalPosition.dx,
        globalPosition.dy,
        globalPosition.dx,
        0,
      ),
      items: const [
        PopupMenuItem(value: 'Change', child: Text('Change')),
        PopupMenuItem(value: 'Delete', child: Text('Delete')),
      ],
    );

    if (selected == 'Change') {
      onEditSelected(
        message['messageId'].toString(),
        message['message'].toString(),
      );
    }

    if (selected == 'Delete') {
      await chatService.deleteMessages(
        message['messageId'].toString(),
        senderId,
        receiverId,
      );
      if (isEditing && editingMessageId == message['messageId']) {
        cancelEditing();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final alignment = isSender ? Alignment.centerRight : Alignment.centerLeft;
    final containerColor = isSender ? Colors.amber : Colors.grey[300];
    final crossAxisAlignment = isSender
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Align(alignment: alignment, child: Text(senderName)),
        Align(
          alignment: alignment,
          child: GestureDetector(
            onLongPressStart: (details) =>
                _showMenu(context, details.globalPosition),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 250),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(message['message'].toString()),
            ),
          ),
        ),
      ],
    );
  }
}
