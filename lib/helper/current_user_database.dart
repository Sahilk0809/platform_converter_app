import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CurrentUserDatabase {
  CurrentUserDatabase._();

  static CurrentUserDatabase currentUserDatabase = CurrentUserDatabase._();

  static const String dbName = 'users.db';
  static const String tableName = 'users';

  Database? _database;

  Future<Database?> get database async => _database ?? await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, dbName);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''
        CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        chatConversation TEXT,
        profile TEXT,
        )
        ''';
        db.execute(sql);
      },
    );
  }

  Future<int> addUserToDatabase({
    required String name,
    required String chatConversation,
    required String profile,
  }) async {
    final db = await database;
    String sql = '''
    INSERT INTO $tableName (name, chatConversation, profile)
    VALUES (?, ?, ?)
    ''';
    List args = [name, chatConversation, profile];
    return await db!.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readDataFromDatabase() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName
    ''';
    return await db!.rawQuery(sql);
  }

  Future<int> updateNameInDatabase(
      String name, String chatConversation, String profile, int id) async {
    final db = await database;
    String sql = '''
    UPDATE $tableName SET name = ?, chatConversation = ?, profile = ? WHERE id = ?
    ''';
    List args = [name, chatConversation, profile, id];
    return await db!.rawUpdate(sql, args);
  }

  Future<int> deleteUserFromDatabase(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM $tableName WHERE id = ?
    ''';
    List args = [id];
    return await db!.rawDelete(sql, args);
  }
}
