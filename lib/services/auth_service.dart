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

  //reset password
  Future sendPasswordResetEmail(String email) async{
    return _firebaseAuth.sendPasswordResetEmail(email: email);
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
