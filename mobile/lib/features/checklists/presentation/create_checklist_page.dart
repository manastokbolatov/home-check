import 'package:flutter/material.dart';

class CreateChecklistPage extends StatelessWidget {
  const CreateChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create checklist'),
      ),
      body: const Center(
        child: Text(
          'Create Checklist',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}