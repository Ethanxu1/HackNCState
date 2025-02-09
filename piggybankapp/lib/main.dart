import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:piggybankapp/chat_backend.dart';
import 'package:piggybankapp/loan_backend.dart';
import 'package:provider/provider.dart';
import 'login_backend.dart';
import 'home_screen.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginBackend()),
        ChangeNotifierProvider(create: (_) => LoanBackend()),
        ChangeNotifierProvider(create: (_) => ChatBackend()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Consumer<LoginBackend>(
        builder: (context, auth, _) => auth.currentUser == null 
            ? const LoginScreen() 
            : const HomeScreen(),
      ),
    );
  }
}