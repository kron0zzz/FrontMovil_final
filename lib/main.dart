import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/data/services/api_service.dart';
import 'package:flutter_app/presentation/screens/login_screen.dart';
import 'package:flutter_app/presentation/screens/main_screen.dart';
import 'package:flutter_app/presentation/screens/forgot_password_screen.dart';
import 'package:flutter_app/presentation/screens/verify_code_screen.dart';
import 'package:flutter_app/presentation/screens/reset_password_screen.dart';

void main() {
  runApp(const MakandApp());
}

class MakandApp extends StatelessWidget {
  const MakandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Makand',
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginWrapper(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/verify-code': (context) => const VerifyCodeScreen(),
        '/reset-password': (context) => const ResetPasswordScreen(),
      },
    );
  }
}

class LoginWrapper extends StatefulWidget {
  const LoginWrapper({super.key});

  @override
  State<LoginWrapper> createState() => _LoginWrapperState();
}

class _LoginWrapperState extends State<LoginWrapper> {
  final _api = ApiService();
  String? _token;
  Map<String, dynamic>? _user;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final token = await _api.getToken();
    if (token != null && mounted) {
      setState(() => _token = token);
    }
  }

  void _handleLogin(String token, Map<String, dynamic> user) {
    setState(() {
      _token = token;
      _user = user;
    });
  }

  void _handleLogout() async {
    await _api.deleteToken();
    setState(() {
      _token = null;
      _user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_token != null) {
      return MainScreen(
        token: _token!,
        user: _user ?? {},
        onLogout: _handleLogout,
      );
    }
    return LoginScreen(onLogin: _handleLogin);
  }
}
