import 'package:flutter/material.dart';

import '../models/family_member.dart';

class AddChildPage extends StatefulWidget {
  const AddChildPage({super.key});

  @override
  State<AddChildPage> createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _save() {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      return;
    }

    final child = FamilyMember(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      role: 'child',
    );

    Navigator.pop(context, child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add child')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Child name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) {
                _save();
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                child: const Text('Add child'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
