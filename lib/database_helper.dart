import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'encryption_helper.dart';
import 'models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'password_manager.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      full_name TEXT,
      password TEXT
    )
    ''');
  }

  // Fungsi untuk menambahkan user profile
  Future<void> insertUserProfile(User user) async {
    final db = await database;
    await db.insert('users', user.toMap());
  }

  // Fungsi untuk mendapatkan user profile berdasarkan username
  Future<User?> getUserProfile(String username) async {
    final db = await database;
    var result =
        await db.query('users', where: 'username = ?', whereArgs: [username]);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }
}
