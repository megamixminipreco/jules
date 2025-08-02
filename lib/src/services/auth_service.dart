import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manifestacao_369/src/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream para verificar o estado de autenticação do usuário
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Método de Login
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // TODO: Melhorar o tratamento de erros para o usuário final
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
      // Após criar o usuário, salva os dados adicionais no Firestore
      await saveUserToFirestore(userCredential.user!, name);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // TODO: Melhorar o tratamento de erros para o usuário final
      print('Erro no cadastro: ${e.message}');
      return null;
    }
  }

  // Método para salvar dados do usuário no Firestore
  Future<void> saveUserToFirestore(User user, String name) async {
    UserModel userModel = UserModel(
      uid: user.uid,
      name: name,
      email: user.email!,
      createdAt: DateTime.now(),
    );
    await _firestore.collection('users').doc(user.uid).set(userModel.toMap());
  }

  // Método de Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
