import 'package:flutter/material.dart';

class RitualScreen extends StatelessWidget {
  const RitualScreen({super.key});

  static const String routeName = '/ritual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ritual Diário 3-6-9'),
      ),
      body: const Center(
        child: Text('Tela do Ritual - Em construção'),
      ),
    );
  }
}
