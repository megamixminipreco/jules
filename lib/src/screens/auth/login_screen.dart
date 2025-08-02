import 'package:flutter/material.dart';
import 'package:manifestacao_369/src/core/theme/app_theme.dart';
import 'package:manifestacao_369/src/screens/auth/signup_screen.dart';
import 'package:manifestacao_369/src/services/auth_service.dart';
import 'package:manifestacao_369/src/widgets/shared/mystic_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final userCredential = await _authService.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (mounted) {
        setState(() => _isLoading = false);
        if (userCredential == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('E-mail ou senha inválidos.'),
              backgroundColor: AppColors.errorRed,
            ),
          );
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
                        'PORTAL 369',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 48),
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
                        validator: (value) => value!.isEmpty ? 'Por favor, insira sua senha' : null,
                      ),
                      const SizedBox(height: 24),
                      if (_isLoading)
                        const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold)))
                      else
                        ElevatedButton(
                          onPressed: _submit,
                          child: const Text('Entrar'),
                        ),
                      const SizedBox(height: 16),
                      // TODO: Implementar Google Sign In com o novo design
                      // ElevatedButton.icon(...)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen())),
                            child: const Text('Criar Conta', style: TextStyle(color: AppColors.textWhite)),
                          ),
                          TextButton(
                            onPressed: () { /* TODO */ },
                            child: const Text('Esqueci a senha', style: TextStyle(color: AppColors.textWhite)),
                          ),
                        ],
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
