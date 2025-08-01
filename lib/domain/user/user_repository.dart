import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
class UserRepository {
  final _db = FirebaseFirestore.instance;

  ///
  Future<void> createUserData(
    User user, {
    String? name,
    String? lastName,
    String? position,
    String? phone,
  }) async {
    await _db.collection('Users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email ?? '',
      'displayName': name ?? user.displayName ?? 'user',
      'lastName': lastName ?? '',
      'phone': phone ?? user.phoneNumber,
      'photoUrl': user.photoURL ?? '',
      'position': '',
      'address': {'country': '', 'state': '', 'city': ''},
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  ///
  Future<void> updateUserName(
    String uid,
    String name,
    String lastName,
    String position,
    String country,
    String? state,
    String city,
  ) {
    return _db.collection('Users').doc(uid).update({
      'displayName': name,
      'lastName': lastName,
      'position': position,
      'address': {'country': country, 'state': state ?? '', 'city': city},
    });
  }

  ///
  Future<void> updateLastLogin(String uid) {
    return _db.collection('Users').doc(uid).update({
      'lastLogin': FieldValue.serverTimestamp(),
    });
  }

  ///
  Future<void> deleteUserData(String uid) {
    return _db.collection('Users').doc(uid).delete();
  }

  ///
  Future<DocumentSnapshot> getUserData(String uid) {
    return _db.collection('Users').doc(uid).get();
  }
}
