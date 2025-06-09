class Reminder {
  final int? id;
  final int noteID;
  final DateTime dateTime;
  final List<int> notificationTimeReminder;

  Reminder({
    this.id,
    required this.noteID,
    required this.dateTime,
    required this.notificationTimeReminder,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'note_id': noteID,
      'date_time': dateTime.toIso8601String(),
      'notification_time_reminder': notificationTimeReminder.join(','),
    };
  }

  Map<String, dynamic> toMapForInsert() {
    return {
      'note_id': noteID,
      'date_time': dateTime.toIso8601String(),
      'notification_time_reminder': notificationTimeReminder.join(','),
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      noteID: map['note_id'],
      dateTime: DateTime.parse(map['date_time']),
      notificationTimeReminder: map['notification_time_reminder']
          .split(',')
          .map((id) => int.tryParse(id))
          .whereType<int>()
          .toList(),
    );
  }
}
