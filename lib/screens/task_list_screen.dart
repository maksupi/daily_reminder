import 'package:flutter/material.dart';

import '../data/sample_tasks.dart';
import '../data/task_storage.dart';
import '../models/task.dart';
import '../utils/format.dart';
import '../widgets/task_calendar.dart';
import '../widgets/task_card.dart';
import 'task_detail_screen.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _storage = TaskStorage();
  List<Task> _tasks = [];
  bool _loading = true;
  DateTime _selectedDay = dateOnly(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  /// Membaca data tersimpan; pada pemakaian pertama, memakai data contoh.
  Future<void> _loadTasks() async {
    final saved = await _storage.load();
    if (!mounted) return;
    setState(() {
      _tasks = saved ?? buildSampleTasks();
      _loading = false;
    });
  }

  /// Mengubah data lalu menyimpannya ke penyimpanan lokal.
  void _update(VoidCallback change) {
    setState(change);
    _storage.save(_tasks);
  }

  /// Tugas pada tanggal yang dipilih, dihitung dari satu sumber data.
  List<Task> get _visibleTasks =>
      _tasks.where((t) => isSameDay(t.dueDate, _selectedDay)).toList();

  Future<void> _openForm() async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(
        builder: (_) => TaskFormScreen(initialDate: _selectedDay),
      ),
    );
    if (newTask != null) {
      _update(() => _tasks.add(newTask));
    }
  }

  Future<void> _openDetail(Task task) async {
    final action = await Navigator.push<DetailAction>(
      context,
      MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task)),
    );
    if (action == DetailAction.toggle) {
      _update(() => task.isDone = !task.isDone);
    } else if (action == DetailAction.delete) {
      _update(() => _tasks.remove(task));
    }
  }

  void _toggle(Task task) => _update(() => task.isDone = !task.isDone);

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final visible = _visibleTasks;

    return Scaffold(
      appBar: AppBar(title: const Text('Daily Reminder')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TaskCalendar(
              tasks: _tasks,
              selectedDay: _selectedDay,
              onDaySelected: (day) => setState(() => _selectedDay = day),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 12, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Tugas - ${formatDate(_selectedDay)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton.filled(
                    onPressed: _openForm,
                    icon: const Icon(Icons.add),
                    tooltip: 'Tambah tugas',
                  ),
                ],
              ),
            ),
          ),
          if (visible.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text('Belum ada tugas untuk tanggal ini')),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final task = visible[i];
                  return TaskCard(
                    task: task,
                    onToggle: () => _toggle(task),
                    onTap: () => _openDetail(task),
                  );
                },
                childCount: visible.length,
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
