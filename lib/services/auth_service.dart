import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //signifies if the user change their login state(sign in or sign out)
  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
    (User user) => user?.uid,
  );

  //get UID
  Future<String> getCurrentUID() async{
    return (_firebaseAuth.currentUser).uid;
  }

  //email and password sign-up
  Future<String> createUserWithEmailAndPassword(String email, String password, String name) async{
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );

    //update username
    await updateUserName(name);
    return currentUser.user.uid;
  }

  Future updateUserName(String name) async {
    await _firebaseAuth.currentUser.updateProfile(displayName: name);
  }

  //email and password sign-in
  Future<String> signInWithEmailAndPassword(String email, String password) async{
    return (await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password)
    ).user.uid;
  }

  //sign out
  signOut() {
    return _firebaseAuth.signOut();
  }

  //reset password
  Future sendPasswordResetEmail(String email) async{
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //anonymous user
  Future signInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  //for creating accounts for anonymous users
  Future convertUserWithEmail(String email, String password, String name) async{
    final currentUser = _firebaseAuth.currentUser;
    final credential = EmailAuthProvider.credential(email: email, password: password);
    await currentUser.linkWithCredential(credential);
    await updateUserName(name);
  }

  //anonymous user => google sign in
  Future convertWithGoogle() async{
    final currentUser = _firebaseAuth.currentUser;
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    await currentUser.linkWithCredential(credential);
    await updateUserName(_googleSignIn.currentUser.displayName);
  }

  //Google signin
  Future<String> signInWithGoogle() async{
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }
}

//form validators for sign_up_view
class NameValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Name can't be empty";
    }
    if(value.length < 2) {
      return "Name must be atleast 2 characters long";
    }
    if(value.length > 50) {
      return "Name must be less than 50 characters";
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}
