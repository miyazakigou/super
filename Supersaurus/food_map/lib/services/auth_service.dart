import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<void> signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
