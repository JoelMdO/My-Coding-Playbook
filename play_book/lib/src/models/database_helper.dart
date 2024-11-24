import 'package:path_provider/path_provider.dart';
import 'package:play_book/src/models/model.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

///[DatabaseHelper] to read the database.
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Initialize sqflite ffi
    sqfliteFfiInit();
    // Change the default factory to FFI
    databaseFactory = databaseFactoryFfi;
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentsDir.path, "databases", "playbook.db");
    final winLinuxDB = await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
    return winLinuxDB;
  }

  Future<void> _onCreate(Database database, int version) async {
    final db = database;
    await db.execute(""" CREATE TABLE IF NOT EXISTS Data(
    DataID INTEGER PRIMARY KEY AUTOINCREMENT,			
    Section TEXT NOT NULL,    
    Subject TEXT NOT NULL,
    Code TEXT NOT NULL,
    Description TEXT
          );
 """);
  }

  Future<void> insertData(
      String section, String subject, String code, String description) async {
    //
    final Database db = await instance.database;
    //
    //
    final result = await db.query(
      'Data',
      columns: ['SectionID', 'Code', 'Description', 'Subject'],
      where: 'Code = ?',
      whereArgs: [code],
    );
    // If exists, update the Code column with a new value (e.g., 'new_value')
    if (result.isNotEmpty) {
      await db.update(
        'Data',
        {
          'Code': 'new_value'
        }, // Change 'new_value' to the actual value you want
        where: 'Code = ?',
        whereArgs: [code],
      );
    } else {
      await db.insert(
          'Data',
          {
            'SectionID': section,
            'Subject': subject,
            'Code': code,
            'Description': description
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Data>> getData(String data) async {
    //
    final Database db = await instance.database;
    List<Map<String, dynamic>> getData = [];
    //

    getData = await db.query(
      'Data',
      columns: ['SectionID', 'Code', 'Description', 'Subject'],
      where:
          'SectionID LIKE "%" || ? || "%"  OR Subject LIKE "%" || ? || "%"  OR Code LIKE "%" || ? || "%" ',
      whereArgs: [data, data, data],
    );
    if (getData.isEmpty) {
      getData = await db.query(
        'Data',
        columns: ['SectionID', 'Code', 'Description', 'Subject'],
        where: 'Subject LIKE "%" || ? || "%" ',
        whereArgs: [data],
      );
      if (getData.isEmpty) {
        getData = await db.query(
          'Data',
          columns: ['SectionID', 'Code', 'Description', 'Subject'],
          where: 'Code LIKE "%" || ? || "%" ',
          whereArgs: [data],
        );
      }
      if (getData.isEmpty) {
        getData = await db.query(
          'Data',
          columns: ['SectionID', 'Code', 'Description', 'Subject'],
          where: 'Description LIKE "%" || ? || "%" ',
          whereArgs: [data],
        );
      }
    } else if (getData.isNotEmpty) {
      return List.generate(getData.length, (i) {
        return Data(
            section: getData[i]['SectionID'],
            code: getData[i]['Code'],
            description: getData[i]['Description'],
            subject: getData[i]['Subject']);
      });
    }
    return List.generate(getData.length, (i) {
      return Data(
          section: getData[i]['SectionID'],
          code: getData[i]['Code'],
          description: getData[i]['Description'],
          subject: getData[i]['Subject']);
    });
  }
}
