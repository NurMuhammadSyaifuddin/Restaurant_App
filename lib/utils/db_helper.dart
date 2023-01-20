import 'package:sqflite/sqflite.dart';
import 'package:submission_3/model/restaurant.dart';

class DBHelper {
  static DBHelper? _dbHelper;
  static late Database _db;
  static const String _tableFavoriteRestaurant = 'favorite_restaurant';

  DBHelper._internal(){
    _dbHelper = this;
  }

  factory DBHelper() => _dbHelper ?? DBHelper._internal();

  Future<Database> get database async {
    _db = await _initializeDB();

    return _db;
  }

  Future<Database> _initializeDB() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/restaurant_db.db',
    onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE $_tableFavoriteRestaurant (
      id TEXT PRIMARY KEY,
      name TEXT, 
      city TEXT,
      pictureId TEXT,
      rating REAL)
      ''');
    },
    version: 1);

    return db;
  }

  Future<void> insertFavoriteRestaurant(Restaurant restaurant) async {
    final db = await database;
    await db.insert(_tableFavoriteRestaurant, restaurant.toMap());
  }

  Future<void> deleteRestaurantFromFavorite(String id) async {
    final db = await database;

    await db.delete(_tableFavoriteRestaurant, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Restaurant>> getFavoriteRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableFavoriteRestaurant);

    List<Restaurant> data = results.isNotEmpty ? results.map((e) => Restaurant.fromMap(e)).toList() : [];

    return data;
  }

  Future<bool> checkFavoriteStatus(String id) async {
    final Database db = await database;
    var query = "SELECT COUNT(*) FROM $_tableFavoriteRestaurant WHERE ID = '$id'";

    return Sqflite.firstIntValue(await db.rawQuery(query)) == 1;
  }

}