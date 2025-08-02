import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_master/features/chat/model/message_class.dart';

///
class ChatService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// POST MESSAGE
  Future<void> sendMessage(String receiveId, String message) async {
    final User? user = _firebaseAuth.currentUser;
    final String curUid = user?.uid ?? '';
    final String curEmail = user?.email ?? '';
    final Timestamp timestamp = Timestamp.now();

    final String generatedMessageId = DateTime.now().millisecondsSinceEpoch
        .toString();

    final MessageClass newMessage = MessageClass(
      senderId: curUid,
      senderEmail: curEmail,
      messageId: generatedMessageId,
      receiveId: receiveId,
      message: message,
      timestamp: timestamp,
    );

    final List<String> ids = [curUid, receiveId];
    ids.sort();
    final String usersChatRoomId = ids.join('_');

    await _firebaseFirestore
        .collection('ChatRooms')
        .doc(usersChatRoomId)
        .collection('Messages')
        .doc(generatedMessageId)
        .set(newMessage.toJson());
  }

  /// GET MESSAGES
  Stream<QuerySnapshot> fetchMessages(String userId, String otherUserId) {
    final List<String> ids = [userId, otherUserId];
    ids.sort();
    final String chatRoomId = ids.join('_');

    return _firebaseFirestore
        .collection('ChatRooms')
        .doc(chatRoomId)
        .collection('Messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  ///DELETE MESSAGES
  Future<void> deleteMessages(
    String messageId,
    String userId,
    String otherUserId,
  ) async {
    final List<String> ids = [userId, otherUserId];
    ids.sort();
    final String chatRoomId = ids.join('_');

    await _firebaseFirestore
        .collection('ChatRooms')
        .doc(chatRoomId)
        .collection('Messages')
        .doc(messageId)
        .delete();
  }

  ///UPDATE MESSAGES
  Future<void> updaeMessages(
    String newMessage,
    String messageId,
    String userId,
    String otherUserId,
  ) async {
    final List<String> ids = [userId, otherUserId];
    ids.sort();
    final String chatRoomId = ids.join('_');

    await _firebaseFirestore
        .collection('ChatRooms')
        .doc(chatRoomId)
        .collection('Messages')
        .doc(messageId)
        .update({'message': newMessage, 'timestamp': Timestamp.now()});
  }

  /// GET USER DATA
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
    return _firebaseFirestore.collection('Users').doc(uid).get();
  }
}
