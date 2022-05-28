import 'dart:async';
import 'package:core/data/models/tv_series/tvseries_table.dart';
import 'package:core/utils/encrypt.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelperTvSeries {
  static DatabaseHelperTvSeries? _databaseHelper;
  DatabaseHelperTvSeries._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelperTvSeries() =>
      _databaseHelper ?? DatabaseHelperTvSeries._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlistTv = 'watchlistTvSeries';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditontontvseries.db';

    var db = await openDatabase(databasePath,
        version: 1,
        onCreate: _onCreate,
        password: encrypt('DitontonAllProtect'));
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistTv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  // TvSeries operation
  Future<int> insertWatchlistTvSeries(TvSeriesTable series) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTv, series.toJson());
  }

  Future<int> removeWatchlistTvSeries(TvSeriesTable series) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [series.id],
    );
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistTv);
    return results;
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
}
