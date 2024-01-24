import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Models/note_model.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'notes';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes_database.db');

    return openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY,
          title TEXT,
          content TEXT,
          time TEXT
        )
      ''');
    });
  }

  Future<int> insertNote(Note note) async {
    final db = await database;
    return await db.insert(tableName, note.toMap());
  }

  Future<List<Note>> getAllNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) {
      return Note.fromMap(maps[index]);
    });
  }

  Future<int> updateNote(Note note) async {
    final db = await database;
    return await db
        .update(tableName, note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
