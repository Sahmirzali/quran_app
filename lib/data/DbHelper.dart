import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app/data/Surah.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SurahDatabase {
  static SurahDatabase _databaseHelper;
  static Database _database;

  String _surahTableName = 'surahs';
  String _id = 'id';
  String _surahNumber = 'surah_number';
  String _verseNumber = 'verse_number';
  String _text = "text";
  String _translation = "translation";
  String _surahName = "surah_name";
  String _isBookmarked = "isBookmarked";
  String _idNum = "idNum";

  SurahDatabase._internal();

  factory SurahDatabase() {
    if (_databaseHelper == null) {
      _databaseHelper = SurahDatabase._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  Directory klasor;
  String sd;

  _initializeDatabase() async {
    klasor = await getExternalStorageDirectory();
    sd = klasor.parent.parent.parent.parent.path;
    String path = join(sd, "QuranDatas", "qurandatabase.db");
    
    await Directory(dirname(path)).create(recursive: true);

    if (!await databaseExists(path)) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      final byteData = await rootBundle.load('assets/DataBase/qurandatabase.db');
      final file = File(path);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    var surahsDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return surahsDB;
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_surahTableName ($_id INTEGER PRIMARY KEY AUTOINCREMENT,$_surahNumber TEXT, $_text TEXT, $_verseNumber TEXT ,$_translation TEXT,$_surahName TEXT, $_isBookmarked INTEGER, $_idNum INTEGER)");
  }

  Future<List<Surah>> searchSurah(String text) async {
    var db = await _getDatabase();
    var sonuc = await db.query(_surahTableName,
        orderBy: '$_surahNumber',
        where: 'lower($_text) like ( "%' +
            text.toLowerCase() +
            '%" ) or lower($_translation) like ( "%' +
            text.toLowerCase() +
            '%" )');
    List<Surah> list = sonuc.map((e) => Surah.fromJson(e)).toList();
    return list;
  }

  Future<List<Surah>> getSurahList(String number) async {
    var db = await _getDatabase();

    var sonuc = await db.query(_surahTableName,
        orderBy: '$_surahNumber',
        where: '$_surahNumber = ?',
        whereArgs: [number]);

    List<Surah> surahLisT = sonuc.map((e) => Surah.fromJson(e)).toList();
    return surahLisT;
  }

  Future<void> setBookmark(Surah surah, bool isBookmark) async {
    var db = await _getDatabase();
    surah.isBookmarked = isBookmark;
    var id = surah.id;
    var s = surah.toMap();
    await db.update(_surahTableName, s, where: '$_id = ?', whereArgs: [id]);
  }

  Future<List<Surah>> getBookmarks() async {
    var db = await _getDatabase();

    var sonuc = await db.query(_surahTableName,
        orderBy: '$_surahNumber', where: '$_isBookmarked = ?', whereArgs: [1]);

    List<Surah> surahLisT = sonuc.map((e) => Surah.fromJson(e)).toList();
    return surahLisT;
  }

  Future<int> insertSurah(Surah surah) async {
    var db = await _getDatabase();
    var sonuc = await db.insert(_surahTableName, surah.toJson());
    return sonuc;
  }

  Future<List<Surah>> allSurah() async {
    var db = await _getDatabase();
    var sonuc = await db.query(_surahTableName, orderBy: '$_surahNumber');

    List<Surah> surahList = sonuc.map((e) => Surah.fromJson(e)).toList();

    return surahList;
  }

  Future<void> deletelall() async {
    var db = await _getDatabase();
    await db.delete(_surahTableName);
  }
}
