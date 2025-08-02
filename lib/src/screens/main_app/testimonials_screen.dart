import 'package:flutter/material.dart';

class TestimonialsScreen extends StatelessWidget {
  const TestimonialsScreen({super.key});

  static const String routeName = '/testimonials';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depoimentos'),
      ),
      body: const Center(
        child: Text('Tela de Depoimentos - Em construção'),
      ),
    );
  }
}
