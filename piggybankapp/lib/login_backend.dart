import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginBackend with ChangeNotifier {
  User? _currentUser;
  
  User? get currentUser => _currentUser;
  
  Future<void> signUp(String email, String password, String name, int age, String phone, String goals) async {
  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    
    await FirebaseFirestore.instance
        .collection('users')
        .doc(credential.user!.uid)
        .set({
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'goals': goals,
      'rating': 500,
      'createdAt': FieldValue.serverTimestamp(),
    });
    
    _currentUser = credential.user;
    notifyListeners();
  } on FirebaseAuthException catch (e) {
    throw Exception(e.message);
  }
}

  Future<void> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _currentUser = credential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _currentUser = null;
    notifyListeners();
  }
}