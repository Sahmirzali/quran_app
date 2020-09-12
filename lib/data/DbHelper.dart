import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app/data/Surah.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SurahDatabase {
  static SurahDatabase _databaseHelper;
  static Database _database;
  //Sutun adları string olarak tanımlanır

  String _surahTableName = 'surahs';
  String _id = 'id';
  String _surahNumber = 'surah_number';
  String _verseNumber = 'verse_number';
  String _text = "text";
  String _translation = "translation";
  String _surahName = "surah_name";
  String _isBookmarked = "isBookmarked";
  String _idNum = "idNum";
  // neden orda int yazdik o zaman o.O Buradakiler column name hmm anladim pardon
  // hocam bi yapsam olur mu ?
  //buraya bi değişken daha ekle sqflitedan çekerken hepsi bir gelsin sana. işaretleyince update yapar bookmark = 1 dersin biter.
  //diğer türlü bii dünya sp kullanman gerek her ayet için.
  // simdi ben bu dbden bookmark db sine ayetleri yolluyorum.  burada yazmam dogru olur mu ?
  //için ayrı db tutmana gerek yok ki
  // bookmark sayfasinda nasil gostercem peki ? bu dbni mi ?gostercem? evet bak
  SurahDatabase._internal();

  factory SurahDatabase() {
    if (_databaseHelper == null) {
      //print("Surahs DATA BASE HELPER NULL, OLUSTURULACAK");
      _databaseHelper = SurahDatabase._internal();
      return _databaseHelper;
    } else {
      //print("Surahs DATA BASE HELPER NULL DEGIL");
      return _databaseHelper;
    }
  }

  Future<Database> _getDatabase() async {
    if (_database == null) {
      //print("Surahs DATA BASE NESNESI NULL, OLUSTURULACAK");
      _database = await _initializeDatabase();
      return _database;
    } else {
      //print("Surahs DATA BASE NESNESI NULL DEĞİL");
      return _database;
    }
  }

// ingilizce db sini
//o iptal değil miydi?
// iptal ama kalmis yani olsun sileriz onu ayns'ı kullanabiliriz
// hocam bunu burdan yapsak olmazmi ?
  Directory klasor;
  String sd;

  //bu kısım telefon hafızasında AppName adında klasör oluşturur içine db dosyasını kopyalar. ve oradan kullanır
  _initializeDatabase() async {
    klasor = await getExternalStorageDirectory();
    sd = klasor.parent.parent.parent.parent.path;
    String path = join(sd, "AppName", "surah.db");
    //AppName kısmını değiştirirsen dosya o isimle oluşur niye degistireyimki ? tamam eger degistirisem tamamdır ben şimdi sonra yine bakarız bişey olursa
    // shared olayina yarin mi bakarsiniz ? evet tama, hocam
    await Directory(dirname(path)).create(recursive: true);
    if (!await databaseExists(path)) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      final byteData = await rootBundle.load('assets/DataBase/surah.db');
      final file = File(path);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
// simdi db telefonda olusacak , sonra telefondan alcaz oylemi ? evet tamam
    //print("Olusan veritabanının tam yolu : $path");
    var surahsDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return surahsDB;
  }

  Future _createDB(Database db, int version) async {
    //print("CREATE DB METHODU CALISTI TABLO OLUSTURULACAK"); // burada ?
    await db.execute(
        "CREATE TABLE $_surahTableName ($_id INTEGER PRIMARY KEY AUTOINCREMENT,$_surahNumber TEXT, $_text TEXT, $_verseNumber TEXT ,$_translation TEXT,$_surahName TEXT, $_isBookmarked INTEGER, $_idNum INTEGER)");
  }

//burası surelerin tablosu işte hocam surah ismi verilmis rastgele  isme takilmayin. ayetler icin . sureler kismi burasi
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
    //hocam uygulamayi silip tekrar calistayimmi ? 1 aye hala saved kalmis şuan sorun yok ama kayboldum projede deminki yazdıklarımız nerede
    //bookmark ekliyoduk ya kodlari yazmistik nasil kaybolur ?
  }

  Future<List<Surah>> getBookmarks() async {
    //telefondaki dosya sildin değil mi tekrar siler misin tamam sildim calistirayimmi ? çal
    var db = await _getDatabase();

    var sonuc = await db.query(_surahTableName,
        orderBy: '$_surahNumber', where: '$_isBookmarked = ?', whereArgs: [1]);
// bu sana bookmarkları dönecek tek 1 veriyi heryerde kullanmış olacaksın
// idnum a gerek yok mu simdi ? gerek yok onun yerine isbookmark ekle. değeri hep 0 olsun
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

// hocam o dosyani siz nasil elde etdiniz bana gondermek icin ? telefon hafizasindan mi aldiniz ? evet
// peki bende buraya kaydetmelimiyim ?
//dosya telefon hafızasında AppName klasöründe oluşuyor
//o dosya doğru yerde şimdi uygulama onu telefona kopyalayacak
