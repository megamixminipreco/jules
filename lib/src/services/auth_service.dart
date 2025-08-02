import 'package:firebase_auth/firebase_auth.dart';
import 'package:manifestacao_369/src/models/user_model.dart';
import 'package:manifestacao_369/src/services/database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _db = DatabaseService();

  // Stream para verificar o estado de autenticação do usuário
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Método de Login
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print('Erro no login: ${e.message}');
      return null;
    }
  }

  // Método de Cadastro
  Future<UserCredential?> signUpWithEmailAndPassword(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Cria o modelo do usuário
      UserModel newUser = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      // Usa o DatabaseService para salvar o usuário
      await _db.createUser(newUser);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Erro no cadastro: ${e.message}');
      return null;
    }
  }

  // Método de Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
