import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_database_demo/home.screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FirestoreDatabaseDemo());
}

class FirestoreDatabaseDemo extends StatelessWidget {
  const FirestoreDatabaseDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
