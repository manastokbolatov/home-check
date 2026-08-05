import 'package:flutter/material.dart';

import '../../checklists/models/sample_checklists.dart';
import '../../checklists/presentation/checklist_page.dart';
import '../../checklists/presentation/create_checklist_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeCheck'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sampleChecklists.length,
        itemBuilder: (context, index) {
          final checklist = sampleChecklists[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(Icons.checklist_rounded),
              title: Text(checklist.title),
              subtitle: Text(
                '${checklist.items.length} tasks',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChecklistPage(
                      checklist: checklist,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateChecklistPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}