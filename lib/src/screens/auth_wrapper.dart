import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manifestacao_369/src/screens/auth/login_screen.dart';
import 'package:manifestacao_369/src/screens/main_app/home_screen.dart';
import 'package:manifestacao_369/src/services/auth_service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // Enquanto espera a conexão, mostra um indicador de progresso
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Se o usuário está logado (snapshot tem dados), mostra a HomeScreen
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Se o usuário não está logado, mostra a LoginScreen
        return const LoginScreen();
      },
    );
  }
}
