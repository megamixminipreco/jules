import 'package:flutter/material.dart';
import 'package:manifestacao_369/src/core/theme/app_theme.dart';
import 'package:manifestacao_369/src/services/auth_service.dart';
import 'package:manifestacao_369/src/widgets/shared/mystic_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final userCredential = await _authService.signUpWithEmailAndPassword(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (mounted) {
        if (userCredential == null) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Erro ao criar conta. Verifique os dados ou tente mais tarde.'),
              backgroundColor: AppColors.errorRed,
            ),
          );
        } else {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MysticBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.filter_vintage, color: AppColors.gold, size: 80),
                      const SizedBox(height: 16),
                      Text(
                        'CRIAR CONTA',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 48),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nome', prefixIcon: Icon(Icons.person_outline, color: AppColors.textWhite)),
                        keyboardType: TextInputType.name,
                        validator: (value) => value!.isEmpty ? 'Por favor, insira seu nome' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'E-mail', prefixIcon: Icon(Icons.email_outlined, color: AppColors.textWhite)),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => value!.isEmpty || !value.contains('@') ? 'Insira um e-mail válido' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: 'Senha', prefixIcon: Icon(Icons.lock_outline, color: AppColors.textWhite)),
                        obscureText: true,
                        validator: (value) => value!.length < 6 ? 'A senha deve ter no mínimo 6 caracteres' : null,
                      ),
                      const SizedBox(height: 24),
                      _isLoading
                          ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold)))
                          : ElevatedButton(
                              onPressed: _submit,
                              child: const Text('Criar Conta'),
                            ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _isLoading ? null : () {
                          if (Navigator.canPop(context)) Navigator.pop(context);
                        },
                        child: const Text('Já tem uma conta? Faça login', style: TextStyle(color: AppColors.textWhite)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
