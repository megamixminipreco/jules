import 'package:flutter/material.dart';

class ReprogrammingScreen extends StatelessWidget {
  const ReprogrammingScreen({super.key});

  static const String routeName = '/reprogramming';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reprogramação Mental'),
      ),
      body: const Center(
        child: Text('Tela de Reprogramação Mental - Em construção'),
      ),
    );
  }
}
