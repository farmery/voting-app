import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;

  //sign in for regular users

  Future signIn() {
    return _googleSignIn.signIn().then((e) {
      print(e);
    });
  }

  //logout
  Future logOutGoogle() {
    return _googleSignIn.signOut();
  }

  //log out admin
  Future logOutAdmin() {
    return auth.signOut();
  }

  //admin auth state
  Stream<User> getAuthState() {
    return auth.authStateChanges();
  }

  //user auth State
  Stream<GoogleSignInAccount> onCurrentUserChange() {
    return _googleSignIn.onCurrentUserChanged;
  }

  //sign in with email
  Future signInWithCredentials(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
