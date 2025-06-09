import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notes/main.dart';
import 'package:flutter_notes/models/Reminder.dart';
import 'package:flutter_notes/utils/Permission.dart';
import 'package:timezone/timezone.dart' as tz;

Future<void> scheduleReminderNotifications(
    Reminder reminder, String noteTitle, String noteContent) async {
  await checkExactAlarmPermission(); // pastikan sudah ada izin exact alarm

  for (int i = 0; i < reminder.notificationTimeReminder.length; i++) {
    final offset = reminder.notificationTimeReminder[i];
    final scheduledTime = reminder.dateTime.subtract(Duration(minutes: offset));

    if (scheduledTime.isAfter(DateTime.now())) {
      final id = reminder.id! * 10 + i;

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        noteTitle,
        noteContent.length > 50
            ? noteContent.substring(0, 50) + '...'
            : noteContent,
        tz.TZDateTime.from(scheduledTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'reminder_channel',
            'Reminder Notifications',
            channelDescription:
                'Channel untuk notifikasi pengingat dari catatan',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      print('Notifikasi dijadwalkan: $scheduledTime | ID: $id');
    }
  }
}
