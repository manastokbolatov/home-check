import 'checklist_item.dart';

class Checklist {
  const Checklist({
    required this.id,
    required this.title,
    required this.items,
    this.assignedChildId,
  });

  final String id;
  final String title;
  final List<ChecklistItem> items;
  final String? assignedChildId;
}
