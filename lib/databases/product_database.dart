import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabase {
  final int version = 1;
  final String databaseName = 'prod2.db';
  final String tableName = 'product';

  Database? _db;

  Future<Database> openDb() async {
    _db ??= await openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (database, version) {
      String query =
          'create table $tableName(id integer primary key, name text, carousel_images text)';
      database.execute(query);
    }, version: version);
    return _db as Database;
  }
}
