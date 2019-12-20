
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Word.dart';




class DbHelper {
  Database _db;
  final String tableWords = "newWords";
  final String columnId = "id";
  final String columnOriginal = "original";
  final String columnTranslate = "translate";

  Future<Database> get db async {
    if (_db!=null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }


  initDb() async {
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder, "Words.db");
    return await openDatabase(path, onCreate: _onCreateDb, version: 1);
  }

  Future<void> _onCreateDb(Database db, int version) async {
    await db.execute("create table $tableWords ($columnId integer primary key autoincrement, $columnOriginal text, $columnTranslate text)");
  }

  Future<List<Word>> getWords() async {
    var dbCleint = await db;
    var result = await dbCleint.query(tableWords, orderBy: columnId);
    return result.map((data)=>Word.fromMap(data)).toList();
  }

  Future<int> insertWord(Word word) async {
    var _dbCleint = await db;
    return await _dbCleint.insert(tableWords,word.toMap());
  }
}