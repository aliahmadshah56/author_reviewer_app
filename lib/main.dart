import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/auth_screen.dart'; // Import AuthScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Author/Reviewer App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthScreen(),  // Set the login screen as the home screen
    );
  }
}
