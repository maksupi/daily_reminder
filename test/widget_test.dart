import 'package:flutter_test/flutter_test.dart';

import 'package:daily_reminder/main.dart';

void main() {
  testWidgets('menampilkan daftar tugas', (tester) async {
    await tester.pumpWidget(const DailyReminderApp());
    expect(find.text('Daily Reminder'), findsOneWidget);
  });
}
