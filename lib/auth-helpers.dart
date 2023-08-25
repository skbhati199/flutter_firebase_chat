import 'package:firebase_auth/firebase_auth.dart';

// Initialize FirebaseAuth instance
final FirebaseAuth _auth = FirebaseAuth.instance;

// Sign up with email and password
Future<UserCredential> signUp(String email, String password) async {
  return await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
}

// Log in with email and password
Future<UserCredential> logIn(String email, String password) async {
  return await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}
