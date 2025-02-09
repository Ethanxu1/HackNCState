import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';

class ChatBackend with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Helper method to get the writable directory.
  Future<Directory> _getLocalDirectory() async {
    // For many platforms, getApplicationDocumentsDirectory() is writable.
    return await getApplicationDocumentsDirectory();
  }

  Future<void> sendMessage(String text, String? recipientId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated');

    final collection = recipientId == null 
        ? _db.collection('chatbot') 
        : _db.collection('chats')
            .doc(_getChatId(user.uid, recipientId))
            .collection('messages');

    // Write the user's message to Firestore.
    await collection.add({
      'text': text,
      'senderId': user.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // If it's a chatbot conversation, run the Python script.
    if (recipientId == null) {
      try {
        // 1. Get the writable directory.
        final directory = await _getLocalDirectory();
        final inputFile = File('${directory.path}/input.txt');
        final outputFile = File('${directory.path}/output.txt');

        // Debug: Print paths to verify where files are written.
        debugPrint('Writing to input.txt at: ${inputFile.path}');
        debugPrint('Expected output.txt path: ${outputFile.path}');

        // 2. Write the user's message to input.txt.
        await inputFile.writeAsString(text);

        // 3. Run chatbot.py using Python.
        // Make sure 'python' is available and chatbot.py is in the working directory.
        final result = await Process.run('python', ['chatbot.py']);
        debugPrint('chatbot.py stdout: ${result.stdout}');
        debugPrint('chatbot.py stderr: ${result.stderr}');
        if (result.exitCode != 0) {
          throw Exception('chatbot.py failed with exit code ${result.exitCode}');
        }

        // 4. Read the chatbot's response from output.txt.
        if (!await outputFile.exists()) {
          throw Exception('Output file not found at ${outputFile.path}');
        }
        final response = await outputFile.readAsString();
        debugPrint('Chatbot response: "$response"');

        // 5. Write the chatbot's response to Firestore.
        await collection.add({
          'text': response,
          'senderId': 'chatbot',
          'timestamp': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        debugPrint('Error generating chatbot response: $e');
        throw Exception('Error generating chatbot response: $e');
      }
    }
  }

  String _getChatId(String a, String b) =>
      a.compareTo(b) < 0 ? '$a-$b' : '$b-$a';

  Stream<QuerySnapshot> getChatStream(String? recipientId) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated');

    return recipientId == null 
        ? _db.collection('chatbot')
            .orderBy('timestamp', descending: true)
            .snapshots()
        : _db.collection('chats')
            .doc(_getChatId(user.uid, recipientId))
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots();
  }
}
