import 'package:firebase_auth/firebase_auth.dart';

///
class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///
  FirebaseAuth get auth => FirebaseAuth.instance;

  ///
  User? get currentUser => FirebaseAuth.instance.currentUser;

  ///
  Future<UserCredential> register(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  ///
  Future<UserCredential> login(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  ///
  Future<void> logout() => _auth.signOut();

  ///
  Future<void> deleteUser() async {
    final user = _auth.currentUser;
    if (user != null) await user.delete();
  }

  ///
  Future<void> updatePassword(String password) async {
    final user = _auth.currentUser;
    if (user != null) await user.updatePassword(password);
  }

  ///
  Future<void> updateDisplayName(String name) async {
    final user = _auth.currentUser;
    if (user != null) await user.updateDisplayName(name);
  }
}
