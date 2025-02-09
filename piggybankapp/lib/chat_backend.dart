import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatBackend with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(String text, String? recipientId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated');
    
    final collection = recipientId == null 
        ? _db.collection('chatbot') 
        : _db.collection('chats').doc(_getChatId(user.uid, recipientId))
            .collection('messages');
    
    await collection.add({
      'text': text,
      'senderId': user.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });
    
    if (recipientId == null) {
      // Generate chatbot response
      final response = _generateChatbotResponse(text);
      await collection.add({
        'text': response,
        'senderId': 'chatbot',
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  String _getChatId(String a, String b) => a.compareTo(b) < 0 ? '$a-$b' : '$b-$a';

  String _generateChatbotResponse(String message) {
    if (message.toLowerCase().contains('loan')) {
      return 'Remember to borrow only what you can repay!';
    }
    if (message.toLowerCase().contains('pay')) {
      return 'Set up a repayment schedule and stick to it!';
    }
    return 'Good financial habits start with small steps!';
  }

  Stream<QuerySnapshot> getChatStream(String? recipientId) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated');
    
    return recipientId == null 
        ? _db.collection('chatbot')
            .orderBy('timestamp', descending: true)
            .snapshots()
        : _db.collection('chats').doc(_getChatId(user.uid, recipientId))
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots();
  }
}