import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:manifestacao_369/main.dart';
import 'package:manifestacao_369/src/screens/auth/login_screen.dart';

// Mock para a inicialização do Firebase em testes
// Baseado na documentação oficial do FlutterFire
// https://firebase.flutter.dev/docs/testing/overview#initialization
Future<void> setupFirebaseCoreMocks() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Injeta uma implementação mock para o Firebase Core
  // Isso evita que o teste tente fazer chamadas de rede reais
  final original = Firebase.delegateFor;
  Firebase.delegateFor = Firebase.delegateFor(
    app: original.app('__test_app__'),
  );
  // Simula a inicialização bem-sucedida
  await Firebase.initializeApp(
    name: '__test_app__',
    options: const FirebaseOptions(
        apiKey: 'test',
        appId: 'test',
        messagingSenderId: 'test',
        projectId: 'test'),
  );
}

void main() {
  setUpAll(() async {
    await setupFirebaseCoreMocks();
  });

  testWidgets('App starts and shows LoginScreen for unauthenticated user', (WidgetTester tester) async {
    // Constrói o nosso app e aciona um frame.
    await tester.pumpWidget(const MyApp());

    // O primeiro frame pode mostrar um CircularProgressIndicator enquanto o stream espera.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Aciona mais um frame para o StreamBuilder receber o estado inicial (usuário nulo).
    await tester.pumpAndSettle();

    // Verifica se a LoginScreen é exibida.
    expect(find.byType(LoginScreen), findsOneWidget);

    // Verifica se a HomeScreen NÃO é exibida.
    expect(find.byType(Scaffold), findsOneWidget); // A LoginScreen tem um Scaffold
    expect(find.text('Manifestação 369'), findsNothing); // Título da HomeScreen
  });
}
