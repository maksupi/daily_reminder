import '../models/task.dart';

List<Task> buildSampleTasks() {
  final now = DateTime.now();
  return [
    Task(
      id: '1',
      title: 'Kerjakan tugas Flutter P03',
      dueDate: now.add(const Duration(days: 1)),
      priority: Priority.tinggi,
    ),
    Task(
      id: '2',
      title: 'Baca bab 4 struktur proyek',
      dueDate: now.add(const Duration(days: 3)),
    ),
    Task(
      id: '3',
      title: 'Merapikan catatan kuliah',
      dueDate: now.add(const Duration(days: 5)),
      priority: Priority.rendah,
    ),
  ];
}
