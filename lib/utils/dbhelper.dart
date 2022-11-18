import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:untitled2/main.dart';

class DbHelper {
  final int version = 1;
  Database? db;
  static final DbHelper dbHelper = DbHelper.internal();
  DbHelper.internal();

  factory DbHelper() {
    //patron singleton
    return dbHelper;
  }

  Future<Database> openDb() async {
    if (db == null) {
      //no existe la BD
      db = await openDatabase(join(await getDatabasesPath(), 'compras_2.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE products(id INTEGER PRIMARY KEY, title TEXT, image TEXT,imageType TEXT)');
      }, version: version);
    }
    return db!;
  }


  Future testDB() async {
    db = await openDb();

    await db!.execute('INSERT INTO products VALUES (0, "aa", "aa","aa")');


    List item = await db!.rawQuery('SELECT * FROM products');

    print(item[0]);
  }
}
