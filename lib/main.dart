import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/data/services/api_service.dart';
import 'package:flutter_app/presentation/screens/login_screen.dart';
import 'package:flutter_app/presentation/screens/main_screen.dart';
import 'package:flutter_app/presentation/screens/forgot_password_screen.dart';
import 'package:flutter_app/presentation/screens/verify_code_screen.dart';
import 'package:flutter_app/presentation/screens/reset_password_screen.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MakandApp());
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginWrapper(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/verify-code',
      builder: (context, state) => const VerifyCodeScreen(),
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final token = extra?['token'] as String? ?? '';
        final user = extra?['user'] as Map<String, dynamic>? ?? {};
        return MainScreen(token: token, user: user, onLogout: () {});
      },
    ),
  ],
);

class MakandApp extends StatelessWidget {
  const MakandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Makand',
      theme: AppTheme.light,
      routerConfig: _router,
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
    context.go('/main', extra: {'token': token, 'user': user});
  }

  void _handleLogout() async {
    await _api.deleteToken();
    if (mounted) {
      setState(() {
        _token = null;
        _user = null;
      });
      context.go('/');
    }
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
