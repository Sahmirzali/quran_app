import 'package:flutter/material.dart';
import 'package:quran_app/ui/bookmark_detail.dart';
import 'detail_surah.dart';
import 'package:quran_app/data/models/allsurah.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Bookmark extends StatefulWidget {
  Bookmark({Key key}) : super(key: key);

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  var database;

  List<AllSurah> allsurah = List<AllSurah>();

  Future initDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'allsurah_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE allsurah(id INTEGER PRIMARY KEY,  text TEXT, translation TEXT, surahNumber TEXT, verseNumber TEXT)",
        );
      },
      version: 1,
    );

    getPeople().then((value) {
      setState(() {
        allsurah = value;
      });
    });
  }

  Future<List<AllSurah>> getPeople() async {
    // Get a reference to the database.
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('allsurah');

    return List.generate(maps.length, (i) {
      return AllSurah(
        id: maps[i]['id'],
        text: maps[i]['text'] as String,
        translation: maps[i]['translation'] as String,
        surahNumber: maps[i]['surahNumber'] as String,
        verseNumber: maps[i]['verseNumber'] as String,
      );
    });
  }

  Future<void> deletePerson(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'allsurah',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the data's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmark'),
      ),
      body: ListView.builder(
          itemCount: allsurah.length,
          itemBuilder: (context, index) {
            var allsurahdata = allsurah[index];
            return ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Text(allsurahdata.surahNumber.toString()),
                      SizedBox(width: 5,),
                      Text(allsurahdata.verseNumber.toString()),
                    ],
                  ),
                  Text(allsurahdata.translation),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookmarkDetail(
                            //id: index,
                            //indexx: allsurah[index].verseNumber,
                            indexx: allsurahdata.verseNumber,
                            detail: allsurah[index].verseNumber.toString(),
                            datam: allsurah[index].translation,
                          )),
                );
              },
              trailing: RaisedButton(
                color: Colors.red,
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  deletePerson(allsurahdata.id).then((value) {
                    getPeople().then((value) {
                      setState(() {
                        allsurah = value;
                      });
                    });
                  });
                },
              ),
            );
          }),
    );
  }
}
