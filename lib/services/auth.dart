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
  Future<User> signInWithGoogle() async {
    User user;
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      } catch (e) {}
    }
    return user;
  }

  Future logOut() {
    _googleSignIn.signOut();
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
