import 'package:flutter_notes/database/DatabaseHelper.dart';
import 'package:flutter_notes/models/Notes.dart';
import 'package:sqflite/sqflite.dart';


class NoteDao {
  Future<void> insertNote(Note note) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('notes', note.toMapForInsert());
  }

  Future<List<Note>> getAllNotes() async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('notes', orderBy: 'updated_date DESC');

    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  Future<void> updateNote(Note note) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
