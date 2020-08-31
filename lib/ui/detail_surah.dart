import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/data/models/allsurah.dart';
import 'package:quran_app/data/services.dart';
import 'package:quran_app/data/uistate.dart';
import 'package:quran_app/data/utils/config_helper.dart';
import 'package:quran_app/data/utils/style.dart';
import 'package:quran_app/ui/settings.dart';

import 'package:path/path.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DetailSurah extends StatefulWidget {
  final detail;
  final information;

  final String indexx;

  DetailSurah(
      {Key key, @required this.detail, this.indexx, this.id, this.information})
      : super(key: key);

  final id;
  @override
  _DetailSurahState createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  var database;

  @override
  void initState() {
    initDb();
    ConfigHelper().getShared(widget.indexx.toString()).then((value) => {
          setState(() {
            ayetid = value;
          }),
        });
    super.initState();
  }

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
    //nerede o button
    /* 
     int surahNumber;
    int verseNumber;
    String text;
    String translation;
     */
  }
  //bookmark icin
  //sorunlu yer neresiydi

  Future<void> insertAyah(AllSurah surah) async {
    if (surah != null) {
      print('surah is not null ' + surah.surahNumber.toString());
      final Database db = await database;
      await db.insert(
        'allsurah',
        surah.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      print('Surah is null');
    }
  }

  String ayetid;
  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(widget.detail),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
            )
          ],
        ),
        body: FutureBuilder<List<AllSurah>>(
          future: ServiceData().loadSurah(widget.indexx),
          builder: (c, snapshot) {
            return snapshot.hasData
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(child: Text('sure aciklamasi')),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      children: [
                                        Text(snapshot.data[i].verseNumber
                                            .toString()),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.bookmark,
                                            ),
                                            onPressed: () {
                                              insertAyah(snapshot.data[i]);
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              snapshot.data[i].verseNumber ==
                                                      ayetid
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                            ),
                                            onPressed: () async {
                                              await ConfigHelper().addShared(
                                                  snapshot.data[i].verseNumber,
                                                  snapshot.data[i].surahNumber
                                                      .toString());
                                              ayetid =
                                                  snapshot.data[i].verseNumber;
                                              await ConfigHelper()
                                                  .addSharedOther(
                                                      widget.detail,
                                                      snapshot
                                                          .data[i].verseNumber);
                                              setState(() {});
                                            }),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    if (ui.arabic)
                                      Text(
                                        snapshot.data[i].text,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    /*ListTile(
                                        leading: Column(
                                          children: [
                                            //Text(snapshot.data.text.keys.elementAt(i)),
                                          ],
                                        ),
                                        title: Text(
                                          '${snapshot.data[i].text}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: ui.fontSize,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),*/
                                    if (ui.terjemahan)
                                      Column(
                                        children: <Widget>[
                                          AppStyle.spaceH10,
                                          Text(
                                            'Translation',
                                            style: AppStyle.end2subtitle,
                                          ),
                                          AppStyle.spaceH5,
                                          Text(
                                            snapshot.data[i].translation,
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              fontSize: ui.fontSizetext,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ));
  }
}
