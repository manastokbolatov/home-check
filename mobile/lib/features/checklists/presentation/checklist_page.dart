import 'package:flutter/material.dart';

import '../models/checklist.dart';
import 'checklist_tile.dart';
import '../../../shared/services/local_storage_service.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key, required this.checklist});

  final Checklist checklist;

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  late List<bool> completed;
  final storage = LocalStorageService();
  int get completedCount => completed.where((item) => item).length;

  double get progress => completedCount / completed.length;

  @override
  void initState() {
  super.initState();

  completed = widget.checklist.items
    .map((item) => item.isCompleted)
    .toList();

  _loadState();
  }

    Future<void> _loadState() async {
    final saved = await storage.loadChecklistState(
        widget.checklist.id,
    );

    if (saved != null && mounted) {
        setState(() {
        completed = saved;
        });
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.checklist.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$completedCount / ${completed.length} completed',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: widget.checklist.items.length,
              itemBuilder: (context, index) {
                return ChecklistTile(
                  item: widget.checklist.items[index],
                  value: completed[index],
                  onChanged: (value) {
                    setState(() {
                      completed[index] = value ?? false;
                    });
                    storage.saveChecklistState(
                    widget.checklist.id,
                    completed,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
