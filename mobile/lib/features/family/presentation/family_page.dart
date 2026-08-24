import 'package:flutter/material.dart';

import '../../../shared/services/local_storage_service.dart';
import '../models/family.dart';
import '../models/family_member.dart';
import 'add_child_page.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key, required this.family});

  final Family family;

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  late Family family;

  final storage = LocalStorageService();

  @override
  void initState() {
    super.initState();

    family = widget.family;
  }

  Future<void> _addChild() async {
    final child = await Navigator.push<FamilyMember>(
      context,
      MaterialPageRoute(builder: (_) => const AddChildPage()),
    );

    if (child == null || !mounted) {
      return;
    }

    final updatedFamily = Family(
      id: family.id,
      name: family.name,
      members: [...family.members, child],
    );

    setState(() {
      family = updatedFamily;
    });

    await storage.saveFamily(family);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(family.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Family members',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: _addChild,
                tooltip: 'Add child',
                icon: const Icon(Icons.person_add_alt_1_outlined),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...family.members.map((member) {
            return Card(
              child: ListTile(
                leading: Icon(
                  member.role == 'parent'
                      ? Icons.family_restroom
                      : Icons.child_care,
                ),
                title: Text(member.name),
                subtitle: Text(member.role == 'parent' ? 'Parent' : 'Child'),
              ),
            );
          }),
        ],
      ),
    );
  }
}
