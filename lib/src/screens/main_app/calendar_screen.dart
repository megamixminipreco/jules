import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  static const String routeName = '/calendar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendário 369'),
      ),
      body: const Center(
        child: Text('Tela do Calendário - Em construção'),
      ),
    );
  }
}
