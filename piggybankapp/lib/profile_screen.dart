import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_backend.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<LoginBackend>().userData;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: userData != null
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${userData['name']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Phone: ${userData['phone']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Rating: ${userData['rating']}', // Using email as a connection code
              style: const TextStyle(fontSize: 18, color: Colors.teal, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              'Connection Code: ${Object.hash(userData['email'], userData['name'])}', // Using email as a connection code
              style: const TextStyle(fontSize: 18, color: Colors.teal, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              'Goals: ${userData['goals']}', // Using email as a connection code
              style: const TextStyle(fontSize: 18, color: Colors.teal, fontWeight: FontWeight.w500),
            ),
          ],
        )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

