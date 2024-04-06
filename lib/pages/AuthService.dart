

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<UserCredential> signInWithGoogle() async {

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for the user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken : gAuth.idToken,
    );

    // finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future<void> signOut() async {
    await _googleSignIn.signOut(); // Sign out from Google
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
  }
}