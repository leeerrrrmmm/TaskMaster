import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_master/domain/auth/auth_repository.dart';
import 'package:task_master/domain/auth/google_auth_service.dart';
import 'package:task_master/domain/user/user_repository.dart';

///
class AuthFacade {
  final AuthRepository _authRepo;
  final GoogleAuthService _googleAuth;
  final UserRepository _userRepo;

  ///
  AuthFacade(this._authRepo, this._googleAuth, this._userRepo);

  /// Email/Password
  Future<UserCredential> registerWithEmail(
    String email,
    String password,
  ) async {
    final userCredential = await _authRepo.register(email, password);
    final user = userCredential.user;

    if (user != null) {
      await _userRepo.createUserData(user);
    }

    return userCredential;
  }

  ///
  Future<UserCredential> loginWithEmail(String email, String password) async {
    final userCredential = await _authRepo.login(email, password);
    final user = userCredential.user;
    if (user != null) await _userRepo.updateLastLogin(user.uid);

    return userCredential;
  }

  /// Google Sign-in
  Future<UserCredential?> loginWithGoogle() async {
    final userCredential = await _googleAuth.signInWithGoogle();
    if (userCredential != null) {
      final user = userCredential.user;
      if (user != null) {
        final doc = await _userRepo.getUserData(user.uid);
        if (!doc.exists) {
          await _userRepo.createUserData(user);
        }
      }
    }

    return userCredential;
  }

  /// Logout & Delete
  Future<void> logout() async {
    await _authRepo.logout();
    await _googleAuth.signOutGoogle();
  }

  ///
  Future<void> deleteAccount() async {
    final uid = _authRepo.currentUser?.uid;
    if (uid != null) {
      await _userRepo.deleteUserData(uid);
      await _authRepo.deleteUser();
    }
  }

  /// Profile update
  Future<void> updateDisplayName(
    String name,
    String lastName,
    String position,
    String country,
    String? state,
    String city,
  ) async {
    final uid = _authRepo.currentUser?.uid;
    if (uid != null) {
      await _authRepo.updateDisplayName(name);
      await _userRepo.updateUserName(
        uid,
        name,
        lastName,
        position,
        country,
        state,
        city,
      );
    }
  }

  ///
  Future<Map<String, dynamic>?> getAdditionalUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      log('Пользователь не авторизован');

      return null;
    }

    final doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      return doc.data();
    } else {
      log('Данные пользователя не найдены в Firestore');

      return null;
    }
  }
}
