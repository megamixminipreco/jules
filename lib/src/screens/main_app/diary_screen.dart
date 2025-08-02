import 'package:flutter/material.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  static const String routeName = '/diary';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diário de Sinais'),
      ),
      body: const Center(
        child: Text('Tela do Diário - Em construção'),
      ),
    );
  }
}
