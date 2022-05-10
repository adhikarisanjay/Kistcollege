import 'package:cloud_firestore/cloud_firestore.dart';
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
    print("verified${user?.emailVerified}");
  }

  final firestoreInstance = FirebaseFirestore.instance;

  Future<bool> storeformFirebase(email, name, phone, address) async {
    try {
      await firestoreInstance.collection("users").add(
          {"name": name, "phone": phone, "email": email, "address": address});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> storeformwithuserid(email, name, phone, address) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    try {
      firestoreInstance.collection("users").doc(firebaseUser?.uid).set(
          {"name": name, "phone": phone, "email": email, "address": address});
      return true;
    } catch (e) {
      return false;
    }
  }
}
