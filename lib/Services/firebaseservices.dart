import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirbaseServices {
  // 4
  Future<bool> signUp(email, password) async {
    print(email);
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(userCredential.user?.email);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> Login(email, password) async {
    print(email);
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(userCredential.user?.email);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  logout() {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseAuth.instance.signOut();
  }

  update() {
    User? user = FirebaseAuth.instance.currentUser;
    // user?.updateDisplayName("Sanjay");
    // user?.sendEmailVerification();
    print(user?.emailVerified);
  }
}
