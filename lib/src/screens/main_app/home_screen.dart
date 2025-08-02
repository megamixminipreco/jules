import 'package:flutter/material.dart';
import 'package:manifestacao_369/src/core/theme/app_theme.dart';
import 'package:manifestacao_369/src/services/auth_service.dart';
import 'package:manifestacao_369/src/widgets/shared/mystic_background.dart';
import 'package:manifestacao_369/src/screens/phrase/phrase_screen.dart';
import 'ritual_screen.dart';
import 'calendar_screen.dart';
import 'diary_screen.dart';
import 'testimonials_screen.dart';
import 'reprogramming_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MysticBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 48),
                Expanded(
                  child: _buildNavigationList(context),
                ),
                _buildLogoutButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Icon(Icons.filter_vintage, color: AppColors.gold, size: 80), // Placeholder for Mandala
        const SizedBox(height: 16),
        Text(
          'PORTAL 369',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Ative seu portal 369 hoje!',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }

  Widget _buildNavigationList(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildNavButton(context, 'Criar/Editar Frase', Icons.edit_note_outlined, const PhraseScreen()),
        _buildNavButton(context, 'Ativar Ritual Diário', Icons.nightlife_outlined, const RitualScreen()),
        _buildNavButton(context, 'Ver Meu Progresso', Icons.calendar_today_outlined, const CalendarScreen()),
        _buildNavButton(context, 'Meu Diário de Sinais', Icons.book_outlined, const DiaryScreen()),
        _buildNavButton(context, 'Depoimentos', Icons.star_outline, const TestimonialsScreen()),
        _buildNavButton(context, 'Reprogramação Mental', Icons.headset_mic_outlined, const ReprogrammingScreen()),
      ],
    );
  }

  Widget _buildNavButton(BuildContext context, String title, IconData icon, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton.icon(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
        icon: Icon(icon, color: AppColors.gold),
        label: Text(title, style: Theme.of(context).textTheme.labelLarge),
        style: TextButton.styleFrom(
          backgroundColor: AppColors.translucent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final AuthService authService = AuthService();
    return TextButton.icon(
      onPressed: () async {
        await authService.signOut();
      },
      icon: const Icon(Icons.logout, color: Colors.white70),
      label: Text('Sair', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white70)),
      style: TextButton.styleFrom(
        backgroundColor: const Color(0x22DD2C00), // Vermelho translúcido
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
