import 'package:flutter/material.dart';

import '../../../shared/services/local_storage_service.dart';
import '../models/family.dart';
import '../models/family_member.dart';

class CreateFamilyPage extends StatefulWidget {
  const CreateFamilyPage({super.key});

  @override
  State<CreateFamilyPage> createState() => _CreateFamilyPageState();
}

class _CreateFamilyPageState extends State<CreateFamilyPage> {
  final familyNameController = TextEditingController();
  final parentNameController = TextEditingController();

  final storage = LocalStorageService();

  @override
  void dispose() {
    familyNameController.dispose();
    parentNameController.dispose();
    super.dispose();
  }

  Future<void> _saveFamily() async {
    final familyName = familyNameController.text.trim();
    final parentName = parentNameController.text.trim();

    if (familyName.isEmpty || parentName.isEmpty) {
      return;
    }

    final parent = FamilyMember(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: parentName,
      role: 'parent',
    );

    final family = Family(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: familyName,
      members: [parent],
    );

    await storage.saveFamily(family);

    if (!mounted) {
      return;
    }

    Navigator.pop(context, family);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create family')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: familyNameController,
              decoration: const InputDecoration(
                labelText: 'Family name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: parentNameController,
              decoration: const InputDecoration(
                labelText: 'Your name',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveFamily,
                child: const Text('Create family'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
