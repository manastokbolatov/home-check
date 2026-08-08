import 'package:flutter/material.dart';

class CreateChecklistPage extends StatefulWidget {
  const CreateChecklistPage({super.key});

  @override
  State<CreateChecklistPage> createState() => _CreateChecklistPageState();
}

class _CreateChecklistPageState extends State<CreateChecklistPage> {
  final titleController = TextEditingController();
  final taskController = TextEditingController();

  final List<String> tasks = [];

  @override
  void dispose() {
    titleController.dispose();
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create checklist'),
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
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    final task = taskController.text.trim();

                    if (task.isEmpty) {
                      return;
                    }

                    setState(() {
                      tasks.add(task);
                      taskController.clear();
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                    ),
                    title: Text(tasks[index]),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}