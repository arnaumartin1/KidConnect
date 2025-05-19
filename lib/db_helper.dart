import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> initDB() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'app.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT
          )
        ''');
      },
    );
  }

  static Future<void> registerUser(String email, String pass) async {
    final db = await initDB();
    await db.insert('users', {'email': email, 'password': pass});
  }

  static Future<Map<String, dynamic>?> findUser(String email) async {
    final db = await initDB();
    final res = await db.query('users', where: 'email = ?', whereArgs: [email]);
    return res.isNotEmpty ? res.first : null;
  }
}
