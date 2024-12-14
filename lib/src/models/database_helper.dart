import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:playbook/src/models/model.dart';
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
    //
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
    // Create the dropdown_items table
    await db.execute("""
    CREATE TABLE IF NOT EXISTS dropdown_items(
      ItemID INTEGER PRIMARY KEY AUTOINCREMENT,
      value TEXT NOT NULL
    );
  """);
    //Add initial value to dropdown for the first time to users to add more
    await db.insert('dropdown_items', {'value': '+ Add More'});
  }

  // Query dropdown items
  Future<List<String>> getDropdownItems() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'dropdown_items',
      columns: ['value'],
      orderBy: 'value ASC',
    );
    return results.map((item) => item['value'] as String).toList();
  }

  // Get +Add More item index on the dropdown list
  Future<int> indexGetAddMore() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'dropdown_items',
      columns: ['ItemID'],
      where: 'value = ?',
      whereArgs: ['+ Add More'],
    );
    return results.first['ItemID'] as int;
  }

  //Add new item to db.
  Future<int> insertNewDropdownItem(String newItemvalue) async {
    final db = await database;
    //Check if the item exists or not in the dropdown list
    final items = await db.query(
      'dropdown_items',
      columns: ['Value'],
      where: 'Value = ?',
      whereArgs: [newItemvalue],
    );
    if (items.isNotEmpty) {
      return 0;
    } else {
      final row = await db.insert('dropdown_items', {'value': newItemvalue},
          conflictAlgorithm: ConflictAlgorithm.replace);
      return row;
    }
  }

  Future<int> updateData(
      String section, String subject, String code, String description) async {
    //
    final Database db = await instance.database;

    //
    //
    List<Map<String, dynamic>> rows = await db.query(
      'Data',
      columns: ['DataID', 'Section', 'Code', 'Description', 'Subject'],
      where: 'Code = ? OR Description = ?',
      whereArgs: [code, description],
    );

    if (rows.isNotEmpty) {
      // Get the first row
      int rowId = rows.first['DataID'];
      final countID = await db.update(
        'Data',
        {'Code': code, 'Description': description},
        where: 'rowid = ?',
        whereArgs: [rowId],
      );
      return countID;
    } else {
      return 0;
    }
  }

  Future<int> insertData(
      String section, String subject, String code, String description) async {
    //
    final Database db = await instance.database;
    //
    //
    final rowID = await db.insert(
        'Data',
        {
          'Section': section,
          'Subject': subject,
          'Code': code,
          'Description': description
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
    return rowID;
  }

  Future<List<Data>> getData(String data) async {
    //
    final Database db = await instance.database;
    List<Map<String, dynamic>> getData = [];

    getData = await db.query(
      'Data',
      columns: ['Section', 'Code', 'Description', 'Subject'],
      where:
          'Section LIKE "%" || ? || "%"  OR Subject LIKE "%" || ? || "%"  OR Code LIKE "%" || ? || "%" ',
      whereArgs: [data, data, data],
    );

    if (getData.isEmpty) {
      getData = await db.query(
        'Data',
        columns: ['Section', 'Code', 'Description', 'Subject'],
        where: 'Subject LIKE "%" || ? || "%" ',
        whereArgs: [data],
      );
      if (getData.isEmpty) {
        getData = await db.query(
          'Data',
          columns: ['Section', 'Code', 'Description', 'Subject'],
          where: 'Code LIKE "%" || ? || "%" ',
          whereArgs: [data],
        );
      }
      if (getData.isEmpty) {
        getData = await db.query(
          'Data',
          columns: ['Section', 'Code', 'Description', 'Subject'],
          where: 'Description LIKE "%" || ? || "%" ',
          whereArgs: [data],
        );
      }
      return List.generate(getData.length, (i) {
        return Data(
            section: getData[i]['Section'],
            code: getData[i]['Code'],
            description: getData[i]['Description'],
            subject: getData[i]['Subject']);
      });
    } else if (getData.isNotEmpty) {
      return List.generate(getData.length, (i) {
        return Data(
            section: getData[i]['Section'],
            code: getData[i]['Code'],
            description: getData[i]['Description'],
            subject: getData[i]['Subject']);
      });
    }
    return List.generate(getData.length, (i) {
      return Data(
          section: getData[i]['Section'],
          code: getData[i]['Code'],
          description: getData[i]['Description'],
          subject: getData[i]['Subject']);
    });
  }
}
