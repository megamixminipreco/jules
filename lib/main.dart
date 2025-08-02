import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:manifestacao_369/src/screens/auth_wrapper.dart';
import 'package:manifestacao_369/src/core/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal 369',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
    );
  }
}
