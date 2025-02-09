import 'package:flutter/material.dart';
import 'package:piggybankapp/profile_screen.dart';
import 'package:provider/provider.dart';
import 'login_backend.dart';
import 'loan_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<LoginBackend>().logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Request Loan'),
            leading: const Icon(Icons.money),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const LoanScreen())),
          ),
          ListTile(
            title: const Text('Chat with Bot'),
            leading: const Icon(Icons.chat),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ChatScreen())),
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Icons.person),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => ProfileScreen())),
          ),
        ],
      ),
    );
  }
}