import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_master/features/chat/services/chat_service.dart';
import 'package:task_master/features/chat/widgets/message_item_list_widget.dart';
import 'package:task_master/features/chat/widgets/send_msg_widget.dart';

///[ChatPage]
class ChatPage extends StatefulWidget {
  /// [ChatPage] constructor

  ///
  final String senderId;

  ///
  final String receiverId;

  ///
  const ChatPage({required this.senderId, required this.receiverId, super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverId,
        _messageController.text,
      );
    }
    _messageController.clear();
  }

  String? receiverName;

  Future<void> fetchReceiverName() async {
    final doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.receiverId)
        .get();

    setState(() {
      receiverName = doc.data()?['displayName'] as String;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchReceiverName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverName.toString())),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _chatService.fetchMessages(
              widget.receiverId,
              _firebaseAuth.currentUser?.uid ?? '',
            ),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              final data = snapshot.data;
              final docs = data?.docs;

              if (docs == null || docs.isEmpty) {
                return const Text("No messages");
              }

              final messages = docs;

              return MessageItemListWidget(
                messages: messages,
                firebaseAuth: _firebaseAuth,
                receiverName: receiverName ?? '',
              );
            },
          ),

          SendMsgWidget(
            messageController: _messageController,
            onTap: sendMessage,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
