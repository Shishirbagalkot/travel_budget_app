import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //signifies if the user change their login state(sign in or sign out)
  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
    (User user) => user?.uid,
  );

  //email and password sign-up
  Future<String> createUserWithEmailAndPassword(String email, String password, String name) async{
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );

    //update username
    await _firebaseAuth.currentUser.updateProfile(displayName: name);
    return currentUser.user.uid;
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
}