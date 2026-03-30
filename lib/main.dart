import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("✅ Firebase Initialized!");
  } catch (e) {
    print("⚠️ Firebase: $e");
  }

  runApp(const SmartYatraApp());
}

class SmartYatraApp extends StatelessWidget {
  const SmartYatraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartYatra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
