import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/services/local_storage_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storage = LocalStorageService();

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final completed = await storage.isOnboardingCompleted();

    if (!mounted) return;

    if (!completed) {
      context.go('/onboarding');
      return;
    }

    final role = await storage.loadUserRole();

    if (!mounted) return;

    if (role == null) {
      context.go('/role-selection');
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}