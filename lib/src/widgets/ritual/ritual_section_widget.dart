import 'package:flutter/material.dart';
import 'package:manifestacao_369/src/core/theme/app_theme.dart';

class RitualSectionWidget extends StatelessWidget {
  final String title;
  final int currentReps;
  final int totalReps;
  final bool isActive;

  const RitualSectionWidget({
    super.key,
    required this.title,
    required this.currentReps,
    required this.totalReps,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.translucent,
        borderRadius: BorderRadius.circular(12),
        border: isActive ? Border.all(color: AppColors.gold, width: 1.5) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título e Contador
          Text(
            '$title ($currentReps/$totalReps)',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: isActive ? AppColors.gold : AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 16),
          // Barra de Progresso Segmentada
          Row(
            children: List.generate(totalReps, (index) {
              return Expanded(
                child: Container(
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    color: index < currentReps ? AppColors.gold : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
