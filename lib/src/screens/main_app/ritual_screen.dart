import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manifestacao_369/src/core/theme/app_theme.dart';
import 'package:manifestacao_369/src/services/database_service.dart';
import 'package:manifestacao_369/src/widgets/ritual/ritual_section_widget.dart';
import 'package:manifestacao_369/src/widgets/shared/mystic_background.dart';
import 'package:manifestacao_369/src/screens/phrase/phrase_screen.dart';

enum RitualSection { morning, afternoon, evening, done }

class RitualScreen extends StatefulWidget {
  const RitualScreen({super.key});

  @override
  State<RitualScreen> createState() => _RitualScreenState();
}

class _RitualScreenState extends State<RitualScreen> {
  final _databaseService = DatabaseService();
  String? _userPhrase;
  bool _isLoading = true;
  String? _userId;

  // Estado do Ritual
  int _morningReps = 0;
  int _afternoonReps = 0;
  int _eveningReps = 0;
  RitualSection _activeSection = RitualSection.morning;

  @override
  void initState() {
    super.initState();
    _loadUserPhraseAndProgress();
  }

  Future<void> _loadUserPhraseAndProgress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userId = user.uid;
      // Carrega a frase e o progresso em paralelo
      final results = await Future.wait([
        _databaseService.getUserPhrase(_userId!),
        _databaseService.getRitualProgress(_userId!),
      ]);

      final phrase = results[0] as String?;
      final progress = results[1] as Map<String, int>?;

      if (mounted) {
        setState(() {
          _userPhrase = phrase;
          if (progress != null) {
            _morningReps = progress['morningReps'] ?? 0;
            _afternoonReps = progress['afternoonReps'] ?? 0;
            _eveningReps = progress['eveningReps'] ?? 0;
          }
          _updateActiveSection();
          _isLoading = false;
        });
      }
    } else {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _updateActiveSection() {
    if (_morningReps < 3) {
      _activeSection = RitualSection.morning;
    } else if (_afternoonReps < 6) {
      _activeSection = RitualSection.afternoon;
    } else if (_eveningReps < 9) {
      _activeSection = RitualSection.evening;
    } else {
      _activeSection = RitualSection.done;
    }
  }

  void _incrementRepetition() {
    if (_userId == null) return;

    setState(() {
      switch (_activeSection) {
        case RitualSection.morning:
          if (_morningReps < 3) {
            _morningReps++;
            _databaseService.updateRitualProgress(_userId!, morning: _morningReps);
          }
          break;
        case RitualSection.afternoon:
          if (_afternoonReps < 6) {
            _afternoonReps++;
            _databaseService.updateRitualProgress(_userId!, afternoon: _afternoonReps);
          }
          break;
        case RitualSection.evening:
          if (_eveningReps < 9) {
            _eveningReps++;
            _databaseService.updateRitualProgress(_userId!, evening: _eveningReps);
          }
          break;
        case RitualSection.done:
          break;
      }
      _updateActiveSection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MysticBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold)))
                    : _buildBody(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textWhite),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Text('Ritual Diário 3-6-9', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.gold)),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_userPhrase == null || _userPhrase!.isEmpty) {
      return _buildNoPhraseMessage(context);
    }
    if (_activeSection == RitualSection.done) {
      return _buildCompletionMessage(context);
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          _buildPhraseBox(context),
          const SizedBox(height: 32),
          RitualSectionWidget(title: 'Manhã', currentReps: _morningReps, totalReps: 3, isActive: _activeSection == RitualSection.morning),
          RitualSectionWidget(title: 'Tarde', currentReps: _afternoonReps, totalReps: 6, isActive: _activeSection == RitualSection.afternoon),
          RitualSectionWidget(title: 'Noite', currentReps: _eveningReps, totalReps: 9, isActive: _activeSection == RitualSection.evening),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _incrementRepetition,
            child: const Text('+1 Repetição'),
          )
        ],
      ),
    );
  }

  Widget _buildPhraseBox(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: AppColors.translucent, borderRadius: BorderRadius.circular(12)),
      child: Text(
        _userPhrase!,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.gold, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildNoPhraseMessage(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Você ainda não definiu sua frase de manifestação.', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => const PhraseScreen()));
                setState(() { _isLoading = true; });
                _loadUserPhraseAndProgress();
              },
              child: const Text('Criar minha frase agora'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, color: Colors.green[400], size: 100),
          const SizedBox(height: 24),
          Text('Parabéns!', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.gold)),
          const SizedBox(height: 8),
          Text('Você concluiu seu ritual de hoje.', style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
