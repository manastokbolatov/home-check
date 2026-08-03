import 'package:flutter/material.dart';

import '../models/checklist.dart';
import 'checklist_tile.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({
    super.key,
    required this.checklist,
  });

  final Checklist checklist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(checklist.title),
      ),
      body: ListView.builder(
        itemCount: checklist.items.length,
        itemBuilder: (context, index) {
          return ChecklistTile(
            item: checklist.items[index],
          );
        },
      ),
    );
  }
}