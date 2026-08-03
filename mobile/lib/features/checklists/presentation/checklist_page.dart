import 'package:flutter/material.dart';

import '../models/checklist.dart';
import 'checklist_tile.dart';

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
  late List<bool> completed;

  @override
  void initState() {
    super.initState();

    completed = widget.checklist.items
        .map((item) => item.isCompleted)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.checklist.title),
      ),
      body: ListView.builder(
        itemCount: widget.checklist.items.length,
        itemBuilder: (context, index) {
          return ChecklistTile(
            item: widget.checklist.items[index],
            value: completed[index],
            onChanged: (value) {
              setState(() {
                completed[index] = value ?? false;
              });
            },
          );
        },
      ),
    );
  }
}