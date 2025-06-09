import 'package:sqflite/sqflite.dart';
import 'package:flutter_notes/database/DatabaseHelper.dart';
import 'package:flutter_notes/models/Reminder.dart';

class ReminderDao {
  Future<int> insertReminder(Reminder reminder) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('reminders', reminder.toMapForInsert());
  }

  Future<List<Reminder>> getAllReminders() async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('reminders', orderBy: 'date_time ASC');

    return List.generate(maps.length, (i) => Reminder.fromMap(maps[i]));
  }

  Future<Reminder?> getReminderByNoteId(int noteId) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'reminders',
      where: 'note_id = ?',
      whereArgs: [noteId],
    );

    if (maps.isNotEmpty) {
      return Reminder.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateReminder(Reminder reminder) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'reminders',
      reminder.toMap(),
      where: 'id = ?',
      whereArgs: [reminder.id],
    );
  }

  Future<void> deleteReminder(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'reminders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
