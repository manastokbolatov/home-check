import 'package:flutter/material.dart';

import '../models/checklist_item.dart';

class ChecklistTile extends StatelessWidget {
  const ChecklistTile({
    super.key,
    required this.item,
  });

  final ChecklistItem item;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: item.isCompleted,
      onChanged: (_) {},
      title: Text(item.title),
    );
  }
}