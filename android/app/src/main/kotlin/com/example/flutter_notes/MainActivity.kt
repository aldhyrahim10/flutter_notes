package com.example.flutter_notes

import android.app.AlarmManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "dexterx.dev/flutter_local_notifications_example"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "areExactAlarmsAllowed") {
                val alarmManager = getSystemService(ALARM_SERVICE) as AlarmManager
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    val isAllowed = alarmManager.canScheduleExactAlarms()
                    result.success(isAllowed)
                } else {
                    result.success(true) // < Android 12 tidak butuh permission
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
