import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_master/features/chat/services/chat_service.dart';
import 'package:task_master/features/chat/widgets/message_input.dart';
import 'package:task_master/features/chat/widgets/message_item_list_widget.dart';

///
class ChatPage extends StatefulWidget {
  ///
  const ChatPage({required this.senderId, required this.receiverId, super.key});

  ///
  final String senderId;

  ///
  final String receiverId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? receiverName;

  bool isEditing = false;
  String? editingMessageId;

  @override
  void initState() {
    super.initState();
    fetchReceiverName();
  }

  Future<void> fetchReceiverName() async {
    final doc = await _chatService.getUserData(widget.receiverId);
    setState(() {
      receiverName = doc.data()?['displayName'] as String? ?? 'Unknown';
    });
  }

  Future<void> sendMessage() async {
    final currentUser = _firebaseAuth.currentUser;
    final senderId = currentUser?.uid ?? '';

    if (_messageController.text.isEmpty) return;

    if (isEditing && editingMessageId != null) {
      await _chatService.updaeMessages(
        _messageController.text,
        editingMessageId ?? '',
        senderId,
        widget.receiverId,
      );
      setState(() {
        isEditing = false;
        editingMessageId = null;
        _messageController.clear();
      });
    } else {
      await _chatService.sendMessage(
        widget.receiverId,
        _messageController.text,
      );
      _messageController.clear();
    }
  }

  void startEditing(String messageId, String messageText) {
    setState(() {
      isEditing = true;
      editingMessageId = messageId;
      _messageController.text = messageText;
    });
  }

  void cancelEditing() {
    setState(() {
      isEditing = false;
      editingMessageId = null;
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _firebaseAuth.currentUser;

    return Scaffold(
      appBar: ChatAppBar(title: receiverName ?? 'Chat'),
      body: Column(
        children: [
          Expanded(
            child: MessageItemListWidget(
              senderId: currentUser?.uid ?? '',
              receiverId: widget.receiverId,
              receiverName: receiverName ?? 'Other',
              chatService: _chatService,
              onEditSelected: startEditing,
              isEditing: isEditing,
              editingMessageId: editingMessageId,
              cancelEditing: cancelEditing,
            ),
          ),
          MessageInput(
            controller: _messageController,
            isEditing: isEditing,
            onSend: sendMessage,
            onCancelEditing: cancelEditing,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

///
class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  ///
  final String title;

  ///
  const ChatAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
