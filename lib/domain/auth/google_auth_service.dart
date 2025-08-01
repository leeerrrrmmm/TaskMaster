import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///
  Future<UserCredential?> signInWithGoogle() async {
    final gUser = await _googleSignIn.signIn();
    if (gUser == null) return null;

    final gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return _auth.signInWithCredential(credential);
  }

  ///
  Future<void> signOutGoogle() => _googleSignIn.signOut();
}
