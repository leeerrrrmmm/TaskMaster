import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// [ChatScreen]
class ChatScreen extends StatefulWidget {
  /// [ChatScreen] constructor
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snap.hasError) {
            return Center(
              child: Text('Sorry, we have a little problem: ${snap.error}'),
            );
          }

          return ListView.builder(
            itemCount: snap.data?.docs.length,
            itemBuilder: (_, index) {
              final doc = snap.data?.docs[index];

              if (doc == null) return const SizedBox();

              final userData = doc.data();
              if (userData is! Map<String, dynamic>) return const SizedBox();

              final uidData = userData['uid'];
              if (user?.uid == uidData) return const SizedBox();

              return GestureDetector(
                onTap: () => context.pushNamed(
                  'chatRoom',
                  extra: {'senderId': user?.uid, 'receiverId': userData['uid']},
                ),
                child: Container(
                  margin: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 16),
                    ],
                  ),
                  child: Center(
                    child: Text(userData['displayName'].toString()),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
