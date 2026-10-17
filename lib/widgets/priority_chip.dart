import 'package:flutter/material.dart';

import '../models/task.dart';

class PriorityChip extends StatelessWidget {
  const PriorityChip({super.key, required this.priority});

  final Priority priority;

  Color get _color => switch (priority) {
        Priority.rendah => Colors.green,
        Priority.sedang => Colors.orange,
        Priority.tinggi => Colors.red,
      };

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(priority.label),
      labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
      backgroundColor: _color,
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }
}
