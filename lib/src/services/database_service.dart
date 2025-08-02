import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manifestacao_369/src/models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _usersCollection = 'users';

  // Salva os dados iniciais de um novo usuário
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection(_usersCollection).doc(user.uid).set(user.toMap());
    } catch (e) {
      print('Erro ao criar usuário no Firestore: $e');
      // Opcional: relançar o erro para ser tratado na UI
    }
  }

  // Atualiza a frase de manifestação do usuário
  Future<void> updateUserPhrase(String userId, String phrase) async {
    try {
      await _firestore.collection(_usersCollection).doc(userId).update({
        'manifestationPhrase': phrase,
        'phraseLastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Erro ao atualizar a frase: $e');
    }
  }

  // Obtém a frase de manifestação do usuário
  Future<String?> getUserPhrase(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection(_usersCollection).doc(userId).get();
      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data() as Map<String, dynamic>;
        return data['manifestationPhrase'] as String?;
      }
      return null;
    } catch (e) {
      print('Erro ao buscar a frase: $e');
      return null;
    }
  }
}
