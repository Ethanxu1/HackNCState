import 'package:flutter/material.dart';

class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({super.key});

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

class _ConnectionsScreenState extends State<ConnectionsScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? _connectionStatus;
  String? _connectionName;

  void _searchConnection() {
    setState(() {
      // Simulated search logic
      if (_codeController.text == "1234") {
        _connectionStatus = "Connection found! You can start chatting.";
        _connectionName = "John Doe"; // Example connection name
      } else {
        _connectionStatus = "Connection not found. Please try again.";
        _connectionName = null;
      }
    });
  }

  void _startChat() {
    if (_connectionName != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(connectionName: _connectionName!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connections')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Enter Connection Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _searchConnection,
              child: const Text('Search Connection'),
            ),
            if (_connectionStatus != null) ...[
              const SizedBox(height: 20),
              Text(
                _connectionStatus!,
                style: TextStyle(
                  color: _connectionStatus == "Connection found! You can start chatting."
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_connectionStatus == "Connection found! You can start chatting.")
                TextButton(
                  onPressed: _startChat,
                  child: const Text('Start Chat'),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final String connectionName;

  const ChatScreen({super.key, required this.connectionName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(connectionName)),
      body: const Center(child: Text('Chat interface here')), // Placeholder for chat UI
    );
  }
}