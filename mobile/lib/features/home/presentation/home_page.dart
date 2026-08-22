import 'package:flutter/material.dart';

import '../../checklists/models/checklist.dart';
import '../../checklists/models/sample_checklists.dart';
import '../../checklists/presentation/checklist_page.dart';
import '../../checklists/presentation/create_checklist_page.dart';
import '../../../shared/services/local_storage_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Checklist> checklists;

  final storage = LocalStorageService();

  String? userRole;

  bool get isParent => userRole == 'parent';

  @override
  void initState() {
    super.initState();

    checklists = List.of(sampleChecklists);

    _loadChecklists();
    _loadUserRole();
  }

  Future<void> _loadChecklists() async {
    final saved = await storage.loadChecklists();

    if (saved != null && mounted) {
      setState(() {
        checklists = saved;
      });
    }
  }

  Future<void> _loadUserRole() async {
    final role = await storage.loadUserRole();

    if (!mounted) {
      return;
    }

    setState(() {
      userRole = role;
    });
  }

  Future<void> _createChecklist() async {
    final checklist = await Navigator.push<Checklist>(
      context,
      MaterialPageRoute(builder: (_) => const CreateChecklistPage()),
    );

    if (checklist == null) {
      return;
    }

    setState(() {
      checklists.add(checklist);
    });

    await storage.saveChecklists(checklists);
  }

  Future<void> _openChecklist(int index) async {
    final updatedChecklist = await Navigator.push<Checklist>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ChecklistPage(checklist: checklists[index], userRole: userRole),
      ),
    );

    if (updatedChecklist == null || !mounted) {
      return;
    }

    setState(() {
      checklists[index] = updatedChecklist;
    });

    await storage.saveChecklists(checklists);
  }

  Future<bool> _confirmDelete(Checklist checklist) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete checklist?'),
          content: Text(
            'Are you sure you want to delete "${checklist.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    return confirmed == true;
  }

  Future<void> _deleteChecklist(int index) async {
    setState(() {
      checklists.removeAt(index);
    });

    await storage.saveChecklists(checklists);
  }

  double _progress(Checklist checklist) {
    if (checklist.items.isEmpty) {
      return 0;
    }

    final completed = checklist.items.where((item) => item.isCompleted).length;

    return completed / checklist.items.length;
  }

  int _completedCount(Checklist checklist) {
    return checklist.items.where((item) => item.isCompleted).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeCheck')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: checklists.length,
        itemBuilder: (context, index) {
          final checklist = checklists[index];

          final completedCount = _completedCount(checklist);

          final progress = _progress(checklist);

          return Dismissible(
            key: ValueKey(checklist.id),
            direction: isParent
                ? DismissDirection.endToStart
                : DismissDirection.none,
            confirmDismiss: (_) {
              return _confirmDelete(checklist);
            },
            onDismissed: (_) {
              _deleteChecklist(index);
            },
            background: Container(
              margin: const EdgeInsets.only(bottom: 16),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  _openChecklist(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.checklist_rounded, size: 32),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              checklist.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$completedCount / '
                        '${checklist.items.length} completed',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: isParent
          ? FloatingActionButton(
              onPressed: _createChecklist,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
