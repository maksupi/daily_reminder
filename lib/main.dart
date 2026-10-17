import 'package:flutter/material.dart';

import 'screens/task_list_screen.dart';

void main() => runApp(const DailyReminderApp());

class DailyReminderApp extends StatelessWidget {
  const DailyReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Reminder',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const TaskListScreen(),
    );
  }
}
