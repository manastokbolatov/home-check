import 'checklist.dart';
import 'checklist_item.dart';

const sampleChecklists = [
  Checklist(
    id: '1',
    title: 'Leaving Home',
    items: [
      ChecklistItem(id: '1', title: 'Turn off the stove'),
      ChecklistItem(id: '2', title: 'Lock the door'),
      ChecklistItem(id: '3', title: 'Close the windows'),
      ChecklistItem(id: '4', title: 'Turn off the lights'),
    ],
  ),
];
