import 'package:ecommerce/databases/product_database.dart';
import 'package:ecommerce/models/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {
  insert(Product product) async {
    Database db = await ProductDatabase().openDb();
    print(product.toMap());
    await db.insert(ProductDatabase().tableName, product.toMap());
    print(product);
  }

  delete(Product product) async {
    Database db = await ProductDatabase().openDb();
    await db.delete(ProductDatabase().tableName,
        where: 'id=?', whereArgs: [product.id]);
    print(product);
  }

  Future<bool> isFavorite(Product product) async {
    Database db = await ProductDatabase().openDb();
    List maps = await db.query(ProductDatabase().tableName,
        where: 'id=?', whereArgs: [product.id]);

    return maps.isNotEmpty;
  }

  Future<List<Product>> getAll() async {
    Database db = await ProductDatabase().openDb();
    final maps = await db.query(ProductDatabase().tableName);
    return maps.map((map) => Product.fromMap(map)).toList();
  }
}
