import 'package:flutter/material.dart';

import '../../checklists/models/checklist.dart';
import '../../checklists/models/sample_checklists.dart';
import '../../checklists/presentation/checklist_page.dart';
import '../../checklists/presentation/create_checklist_page.dart';
import '../../family/models/family.dart';
import '../../family/presentation/create_family_page.dart';
import '../../family/presentation/family_page.dart';
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
  Family? family;

  bool get isParent => userRole == 'parent';

  List<Checklist> get visibleChecklists {
    if (isParent) {
      return checklists;
    }

    final child = family?.members
        .where((member) => member.role == 'child')
        .firstOrNull;

    if (child == null) {
      return [];
    }

    return checklists
        .where((checklist) => checklist.assignedChildId == child.id)
        .toList();
  }

  @override
  void initState() {
    super.initState();

    checklists = List.of(sampleChecklists);

    _loadChecklists();
    _loadUserRole();
    _loadFamily();
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

  Future<void> _loadFamily() async {
    final savedFamily = await storage.loadFamily();

    if (!mounted) {
      return;
    }

    setState(() {
      family = savedFamily;
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

  Future<void> _openChecklist(String checklistId) async {
    final index = checklists.indexWhere(
      (checklist) => checklist.id == checklistId,
    );

    if (index == -1) {
      return;
    }

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

  Future<void> _deleteChecklist(String checklistId) async {
    setState(() {
      checklists.removeWhere((checklist) => checklist.id == checklistId);
    });

    await storage.saveChecklists(checklists);
  }

  Future<void> _assignChecklist(String checklistId) async {
    final currentFamily = family;

    if (currentFamily == null) {
      return;
    }

    final children = currentFamily.members
        .where((member) => member.role == 'child')
        .toList();

    if (children.isEmpty) {
      return;
    }

    final selectedChildId = await showDialog<String?>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text('Assign to child'),
          children: [
            ...children.map((child) {
              return SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(dialogContext, child.id);
                },
                child: Text(child.name),
              );
            }),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Unassign'),
            ),
          ],
        );
      },
    );

    if (!mounted) {
      return;
    }

    final index = checklists.indexWhere(
      (checklist) => checklist.id == checklistId,
    );

    if (index == -1) {
      return;
    }

    final checklist = checklists[index];

    final updatedChecklist = Checklist(
      id: checklist.id,
      title: checklist.title,
      items: checklist.items,
      assignedChildId: selectedChildId,
    );

    setState(() {
      checklists[index] = updatedChecklist;
    });

    await storage.saveChecklists(checklists);
  }

  Future<void> _createFamily() async {
    final createdFamily = await Navigator.push<Family>(
      context,
      MaterialPageRoute(builder: (_) => const CreateFamilyPage()),
    );

    if (createdFamily == null || !mounted) {
      return;
    }

    setState(() {
      family = createdFamily;
    });
  }

  Future<void> _openFamily() async {
    final currentFamily = family;

    if (currentFamily == null) {
      return;
    }

    await Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (_) => FamilyPage(family: currentFamily)),
    );

    await _loadFamily();
  }

  String _assignedChildName(Checklist checklist) {
    final childId = checklist.assignedChildId;

    if (childId == null || family == null) {
      return 'Not assigned';
    }

    for (final member in family!.members) {
      if (member.id == childId) {
        return 'Assigned to: ${member.name}';
      }
    }

    return 'Not assigned';
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
      appBar: AppBar(
        title: const Text('HomeCheck'),
        actions: [
          if (isParent && family == null)
            IconButton(
              onPressed: _createFamily,
              tooltip: 'Create family',
              icon: const Icon(Icons.group_add_outlined),
            ),
          if (isParent && family != null)
            IconButton(
              onPressed: _openFamily,
              tooltip: 'Open family',
              icon: const Icon(Icons.family_restroom),
            ),
        ],
      ),
      body: visibleChecklists.isEmpty
          ? const Center(child: Text('No checklists assigned yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: visibleChecklists.length,
              itemBuilder: (context, index) {
                final checklist = visibleChecklists[index];

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
                    _deleteChecklist(checklist.id);
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
                        _openChecklist(checklist.id);
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ),
                                if (isParent)
                                  IconButton(
                                    tooltip: 'Assign to child',
                                    onPressed: () {
                                      _assignChecklist(checklist.id);
                                    },
                                    icon: Icon(
                                      checklist.assignedChildId == null
                                          ? Icons.person_add_alt_1_outlined
                                          : Icons.person_outline,
                                    ),
                                  ),
                                const Icon(Icons.chevron_right),
                              ],
                            ),
                            Text(
                              '$completedCount / '
                              '${checklist.items.length} completed',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            if (isParent) ...[
                              const SizedBox(height: 6),
                              Text(
                                _assignedChildName(checklist),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
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
