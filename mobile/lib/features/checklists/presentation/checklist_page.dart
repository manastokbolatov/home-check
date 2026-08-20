import 'package:flutter/material.dart';

import '../models/checklist.dart';
import '../models/checklist_item.dart';
import 'checklist_tile.dart';
import 'create_checklist_page.dart';
import '../../../shared/services/local_storage_service.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({
    super.key,
    required this.checklist,
  });

  final Checklist checklist;

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  late Checklist checklist;
  late List<bool> completed;

  final storage = LocalStorageService();

  int get completedCount =>
      completed.where((item) => item).length;

  double get progress {
    if (completed.isEmpty) {
      return 0;
    }

    return completedCount / completed.length;
  }

  @override
  void initState() {
    super.initState();

    checklist = widget.checklist;

    completed = checklist.items
        .map((item) => item.isCompleted)
        .toList();

    _loadState();
  }

  Future<void> _loadState() async {
    final saved = await storage.loadChecklistState(
      checklist.id,
    );

    if (saved == null || !mounted) {
      return;
    }

    setState(() {
      completed = List.generate(
        checklist.items.length,
        (index) {
          if (index < saved.length) {
            return saved[index];
          }

          return false;
        },
      );
    });
  }

  Future<void> _saveCompletedState(
    int index,
    bool value,
  ) async {
    setState(() {
      completed[index] = value;

      final updatedItems = checklist.items.map(
        (item) {
          final itemIndex =
              checklist.items.indexOf(item);

          if (itemIndex == index) {
            return ChecklistItem(
              id: item.id,
              title: item.title,
              isCompleted: value,
            );
          }

          return item;
        },
      ).toList();

      checklist = Checklist(
        id: checklist.id,
        title: checklist.title,
        items: updatedItems,
      );
    });

    await _saveChecklist();
  }

  Future<void> _editChecklist() async {
    final updatedChecklist =
        await Navigator.push<Checklist>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateChecklistPage(
          checklist: checklist,
        ),
      ),
    );

    if (updatedChecklist == null || !mounted) {
      return;
    }

    final updatedItems = updatedChecklist.items.map(
      (item) {
        final oldIndex = checklist.items.indexWhere(
          (oldItem) => oldItem.id == item.id,
        );

        if (oldIndex != -1 &&
            oldIndex < completed.length) {
          return ChecklistItem(
            id: item.id,
            title: item.title,
            isCompleted: completed[oldIndex],
          );
        }

        return item;
      },
    ).toList();

    final newChecklist = Checklist(
      id: updatedChecklist.id,
      title: updatedChecklist.title,
      items: updatedItems,
    );

    setState(() {
      checklist = newChecklist;

      completed = newChecklist.items
          .map((item) => item.isCompleted)
          .toList();
    });

    await _saveChecklist();
  }

  Future<void> _saveChecklist() async {
    final savedChecklists =
        await storage.loadChecklists();

    if (savedChecklists == null) {
      return;
    }

    final index = savedChecklists.indexWhere(
      (item) => item.id == checklist.id,
    );

    if (index == -1) {
      return;
    }

    savedChecklists[index] = checklist;

    await storage.saveChecklists(savedChecklists);

    await storage.saveChecklistState(
      checklist.id,
      completed,
    );
  }

  Future<void> _editTask(int index) async {
    var editedTitle = checklist.items[index].title;

    final newTitle = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit task'),
          content: TextFormField(
            initialValue: editedTitle,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Task name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              editedTitle = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = editedTitle.trim();

                if (title.isEmpty) {
                  return;
                }

                Navigator.of(dialogContext).pop(title);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (newTitle == null || !mounted) {
      return;
    }

    final updatedItems = List<ChecklistItem>.from(
      checklist.items,
    );

    final oldItem = updatedItems[index];

    updatedItems[index] = ChecklistItem(
      id: oldItem.id,
      title: newTitle,
      isCompleted: oldItem.isCompleted,
    );

    setState(() {
      checklist = Checklist(
        id: checklist.id,
        title: checklist.title,
        items: updatedItems,
      );
    });

    await _saveChecklist();
  }

  void _goBack() {
    Navigator.pop(context, checklist);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        _goBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(checklist.title),
          actions: [
            IconButton(
              onPressed: _editChecklist,
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    '$completedCount / ${completed.length} completed',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: checklist.items.length,
                itemBuilder: (context, index) {
                  return ChecklistTile(
                    item: checklist.items[index],
                    value: completed[index],
                    onChanged: (value) {
                      _saveCompletedState(
                        index,
                        value ?? false,
                      );
                    },
                    onEdit: () {
                      _editTask(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}