import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/services/local_storage_service.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  Future<void> _selectRole(BuildContext context, String role) async {
    final storage = LocalStorageService();

    await storage.saveUserRole(role);

    if (context.mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose your role')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _selectRole(context, 'parent');
                },
                icon: const Icon(Icons.family_restroom),
                label: const Text('Parent'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _selectRole(context, 'child');
                },
                icon: const Icon(Icons.child_care),
                label: const Text('Child'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
