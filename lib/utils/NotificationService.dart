import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notes/main.dart';
import 'package:timezone/timezone.dart' as tz;

void showNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'Notifikasi Judul',
    'Isi Notifikasi',
    platformDetails,
  );
}

void scheduleNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, 
    'Reminder', 
    'Ini notifikasi terjadwal', 
    tz.TZDateTime.now(tz.local).add(Duration(seconds: 10)),
    NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id', // ganti sesuai channel kamu
        'channel_name',
        channelDescription: 'Deskripsi channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}



