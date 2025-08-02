import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manifestacao_369/src/core/theme/app_theme.dart';
import 'package:manifestacao_369/src/services/database_service.dart';
import 'package:manifestacao_369/src/widgets/shared/mystic_background.dart';

class PhraseScreen extends StatefulWidget {
  const PhraseScreen({super.key});

  @override
  State<PhraseScreen> createState() => _PhraseScreenState();
}

class _PhraseScreenState extends State<PhraseScreen> {
  final _databaseService = DatabaseService();
  final _textController = TextEditingController();
  bool _isLoading = true;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserAndPhrase();
  }

  Future<void> _loadCurrentUserAndPhrase() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userId = user.uid;
      final phrase = await _databaseService.getUserPhrase(_userId!);
      if (phrase != null) {
        _textController.text = phrase;
      }
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _savePhrase() async {
    if (_userId == null) return;

    setState(() => _isLoading = true);
    await _databaseService.updateUserPhrase(_userId!, _textController.text);
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Sua frase foi salva com sucesso! ✨'),
          backgroundColor: Colors.green[800],
        ),
      );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
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
            child: Text(
              'Frase de Manifestação',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.gold),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text(
            'Escreva sua frase no presente, agradecendo como se já fosse realidade.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: TextField(
              controller: _textController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: 'Universo, eu agradeço por já ter recebido...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.translucent)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.gold)),
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () { /* TODO: IA Logic */ },
            icon: const Icon(Icons.sparkles_outlined),
            label: const Text('Gerar Sugestão com IA'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8b5cf6), foregroundColor: AppColors.textWhite),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _savePhrase,
            child: const Text('Salvar Frase'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
