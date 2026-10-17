import 'package:flutter/material.dart';

import '../models/task.dart';
import '../utils/format.dart';

class TaskCalendar extends StatefulWidget {
  const TaskCalendar({
    super.key,
    required this.tasks,
    required this.selectedDay,
    required this.onDaySelected,
  });

  final List<Task> tasks;
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  @override
  State<TaskCalendar> createState() => _TaskCalendarState();
}

class _TaskCalendarState extends State<TaskCalendar> {
  static const _hari = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];

  late DateTime _month;

  @override
  void initState() {
    super.initState();
    _month = DateTime(widget.selectedDay.year, widget.selectedDay.month);
  }

  void _shiftMonth(int delta) {
    setState(() => _month = DateTime(_month.year, _month.month + delta));
  }

  void _goToToday() {
    final today = dateOnly(DateTime.now());
    setState(() => _month = DateTime(today.year, today.month));
    widget.onDaySelected(today);
  }

  Widget _buildDay(DateTime day, DateTime today, ColorScheme scheme) {
    final isSelected = isSameDay(day, widget.selectedDay);
    final isToday = isSameDay(day, today);
    final hasTask = widget.tasks.any((t) => isSameDay(t.dueDate, day));

    return Padding(
      padding: const EdgeInsets.all(2),
      child: GestureDetector(
        onTap: () => widget.onDaySelected(day),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? scheme.primary
                : (isToday ? scheme.primaryContainer : null),
            border: Border.all(color: scheme.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${day.day}',
                style: TextStyle(
                  color: isSelected ? scheme.onPrimary : scheme.onSurface,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 2),
              if (hasTask)
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isSelected ? scheme.onPrimary : scheme.primary,
                    shape: BoxShape.circle,
                  ),
                )
              else
                const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final today = DateTime.now();
    
    final offset = DateTime(_month.year, _month.month, 1).weekday % 7;
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;

    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${namaBulan(_month.month)} ${_month.year}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: () => _shiftMonth(-1),
                  icon: const Icon(Icons.chevron_left),
                  tooltip: 'Bulan sebelumnya',
                ),
                FilledButton(
                  onPressed: _goToToday,
                  child: const Text('Hari Ini'),
                ),
                IconButton(
                  onPressed: () => _shiftMonth(1),
                  icon: const Icon(Icons.chevron_right),
                  tooltip: 'Bulan berikutnya',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                for (final h in _hari)
                  Expanded(
                    child: Center(
                      child: Text(h, style: Theme.of(context).textTheme.labelMedium),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var i = 0; i < offset; i++) const SizedBox.shrink(),
                for (var d = 1; d <= daysInMonth; d++)
                  _buildDay(DateTime(_month.year, _month.month, d), today, scheme),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
