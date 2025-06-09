import 'package:android_intent_plus/android_intent.dart';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';

Future<void> checkExactAlarmPermission() async {
  if (Platform.isAndroid) {
    const platform =
        MethodChannel('dexterx.dev/flutter_local_notifications_example');

    try {
      final bool isAllowed =
          await platform.invokeMethod('areExactAlarmsAllowed');
      if (!isAllowed) {
        final intent = AndroidIntent(
          action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
        );
        await intent.launch();
      }
    } on PlatformException catch (e) {
      print("Error: $e");
    }
  }
}
