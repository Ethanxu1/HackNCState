import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoanBackend with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> requestLoan(double amount) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated');
    
    final userData = await _db.collection('users').doc(user.uid).get();
    final rating = userData.data()!['rating'];
    final age = userData.data()!['age'];
    
    if (age < 16 || age > 19) throw Exception('Invalid age');
    if (amount > rating * 100) throw Exception('Amount exceeds limit');
    
    await _db.collection('loans').add({
      'userId': user.uid,
      'amount': amount,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getLoanHistory() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated');
    
    return _db.collection('loans')
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}