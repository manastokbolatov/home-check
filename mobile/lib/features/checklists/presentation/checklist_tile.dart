import 'package:flutter/material.dart';

import '../models/checklist_item.dart';

class ChecklistTile extends StatelessWidget {
  const ChecklistTile({
    super.key,
    required this.item,
    required this.value,
    required this.onChanged,
    required this.onEdit,
  });

  final ChecklistItem item;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(item.title),
      secondary: IconButton(
        onPressed: onEdit,
        icon: const Icon(Icons.edit_outlined),
      ),
    );
  }
}