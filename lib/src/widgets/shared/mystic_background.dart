import 'package:flutter/material.dart';
import 'package:manifestacao_369/src/core/theme/app_theme.dart';

class MysticBackground extends StatelessWidget {
  final Widget child;

  const MysticBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryPurple,
            AppColors.secondaryPurple,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
      // TODO: Adicionar as partículas de brilho dourado aqui
    );
  }
}
