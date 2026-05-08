import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDB {
  static Database? db;

  static Future<Database> getDB() async {
    if (db != null) return db!;
    db = await init();
    return db!;
  }

  static Future<Database> init() async {
    final path = join(await getDatabasesPath(), 'admin_v5.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, v) async {

        await db.execute('''
          CREATE TABLE persons(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            number TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE status(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            personId INTEGER,
            month TEXT,
            year TEXT,
            status TEXT
          )
        ''');
      },
    );
  }

  static Future<int> addPerson(String name, String number) async {
    final d = await getDB();
    return d.insert('persons', {
      'name': name,
      'number': number,
    });
  }

  static Future<List<Map<String, dynamic>>> getPersons() async {
    final d = await getDB();
    return d.query('persons');
  }
}
