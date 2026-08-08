import 'package:flutter/material.dart';

import '../../checklists/models/checklist.dart';
import '../../checklists/models/sample_checklists.dart';
import '../../checklists/presentation/checklist_page.dart';
import '../../checklists/presentation/create_checklist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Checklist> checklists;

  @override
  void initState() {
    super.initState();

    checklists = List.of(sampleChecklists);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeCheck'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: checklists.length,
        itemBuilder: (context, index) {
          final checklist = checklists[index];

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
        onPressed: () async {
          final checklist = await Navigator.push<Checklist>(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateChecklistPage(),
            ),
          );

          if (checklist == null) {
            return;
          }

          setState(() {
            checklists.add(checklist);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

