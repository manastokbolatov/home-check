import 'package:flutter/material.dart';

import '../models/checklist.dart';
import '../models/checklist_item.dart';

class CreateChecklistPage extends StatefulWidget {
  const CreateChecklistPage({
    super.key,
    this.checklist,
  });

  final Checklist? checklist;

  @override
  State<CreateChecklistPage> createState() => _CreateChecklistPageState();
}

class _CreateChecklistPageState extends State<CreateChecklistPage> {
  late final TextEditingController titleController;
  late final TextEditingController taskController;

  late List<ChecklistItem> tasks;

  bool get isEditing => widget.checklist != null;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(
      text: widget.checklist?.title ?? '',
    );

    taskController = TextEditingController();

    tasks = widget.checklist?.items.toList() ?? [];
  }

  @override
  void dispose() {
    titleController.dispose();
    taskController.dispose();
    super.dispose();
  }

  void _addTask() {
    final title = taskController.text.trim();

    if (title.isEmpty) {
      return;
    }

    setState(() {
      tasks.add(
        ChecklistItem(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: title,
        ),
      );

      taskController.clear();
    });
  }

  void _save() {
    final title = titleController.text.trim();
    final task = taskController.text.trim();

    if (title.isEmpty) {
      return;
    }

    if (task.isNotEmpty) {
      tasks.add(
        ChecklistItem(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: task,
        ),
      );

      taskController.clear();
    }

    if (tasks.isEmpty) {
      return;
    }

    final checklist = Checklist(
      id: widget.checklist?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      items: tasks,
    );

    Navigator.pop(context, checklist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit checklist' : 'Create checklist',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Checklist title',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      labelText: 'Task',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),

                const SizedBox(width: 8),

                IconButton(
                  onPressed: _addTask,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return ListTile(
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                    ),
                    title: Text(task.title),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          tasks.removeAt(index);
                        });
                      },
                      icon: const Icon(Icons.delete_outline),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}