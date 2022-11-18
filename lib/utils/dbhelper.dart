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
      db = await openDatabase(join(await getDatabasesPath(), 'comprasssss.db'),
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

  Future<int> insertList(Producto list) async {
    await openDb();

    int id = await db!.insert('products', list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace); //super importante
    // esta propiedad hace q este metodo funcioen como "insert" y "update"

    return id;
  }

  Future<List<Producto>> getLists() async {
    await openDb();

    final List<Map<String, dynamic>> maps = await db!.query('products');
    print(maps);
    return List.generate(maps.length, (i) {
      return Producto(
        maps[i]['id'],
        maps[i]['title'],
        maps[i]['image'],
        maps[i]['imageType'],
      );
    });
  }
  Future<int> deleteProduct(Producto item) async{
    await openDb();

    int result=
    await db!.delete("products", where:"id=?",whereArgs:[item.id]);
    return result;
  }

}
