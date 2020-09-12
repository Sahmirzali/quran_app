/*

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/data/DbHelper.dart';
import 'package:quran_app/data/Surah.dart';
import 'package:quran_app/data/models/allsurah.dart';
import 'package:quran_app/data/services.dart';
import 'package:quran_app/data/themes.dart';
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
  final type;
  final ayahcount;
  final endnumber;

  final String indexx;

  DetailSurah(
      {Key key,
      @required this.detail,
      this.indexx,
      this.id,
      this.information,
      this.type,
      this.ayahcount,
      this.endnumber})
      : super(key: key);

  final id;
  @override
  _DetailSurahState createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  var database;

  var _controller = ScrollController();

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
          "CREATE TABLE allsurah(id INTEGER PRIMARY KEY,  text TEXT, translation TEXT, surahName TEXT, surahNumber TEXT, verseNumber TEXT)",
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

  Future<void> insertAyah(Surah surah) async {
    if (surah != null) {
      print('surah is not null ' + surah.surahNumber);
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

  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  final ScrollController _arrowsController = ScrollController();
  String ayetid;
  @override
  Widget build(BuildContext context) {
    var textScale = MediaQuery.of(context).textScaleFactor;
    var ui = Provider.of<UiState>(context);
    var thememode = Provider.of<ThemeNotifier>(context);
    return Scaffold(
        //backgroundColor: Colors.white,

        //burası dimi hocam evet
        //isterseniz sayfanın yedeğini alın bi/ hocam bu scaffoldun yerine single child mi yapsam simdi gordum :D
        //scaffold nerde ki :D ama oda olmaz neyse bosverin ) 

        body: FutureBuilder<List<Surah>>(
      future: SurahDatabase().getSurahList(widget.indexx),
      builder: (c, snapshot) {
        return snapshot.hasData
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 21,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 4,
                            ),
                            IconButton(
                              icon: Icon(Icons.keyboard_backspace),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            Text(
                              "${widget.detail} surəsi",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20 * textScale,
                                fontWeight: FontWeight.w600,
                                //color: Colors.deepPurple[900],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Settings()));
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              widget.detail == null ? " " : "${widget.detail}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 26 * textScale,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.type == null ? " " : widget.type,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16 * textScale,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              widget.ayahcount.toString() == null
                                  ? " "
                                  : "${widget.ayahcount.toString()} ayədir",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16 * textScale,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 55,
                            ),
                          ],
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.33334,
                      width: MediaQuery.of(context).size.width * 0.86888,
                      //height: MediaQuery.of(context).size.height - 420.0,
                      //width: MediaQuery.of(context).size.width - 49.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          //color: Colors.blue,
                          image: DecorationImage(
                              image: AssetImage("images/lastayah.jpg"),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(height: 15),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 7.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: thememode.darkmode
                                          ? Colors.purple[900]
                                          : Color(0xFF863ED5)
                                              .withOpacity(0.055433222222),
                                      //color: Color(0xFF863ED5)
                                      //  .withOpacity(0.055433222222),
                                      borderRadius: BorderRadius.circular(10)),
                                  //color: Colors.grey,
                                  height: 47,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //SizedBox(width: 0,),

                                        Text(
                                          snapshot.data[i].verseNumber,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),

                                        SizedBox(
                                          width: 20,
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  Icons.bookmark_border,
                                                ),
                                                onPressed: () {
                                                  insertAyah(snapshot.data[i]);
                                                }),
                                            IconButton(
                                                icon: Icon(
                                                  snapshot.data[i]
                                                              .verseNumber ==
                                                          ayetid
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                ),
                                                onPressed: () async {
                                                  await ConfigHelper()
                                                      .addShared(
                                                          snapshot.data[i]
                                                              .verseNumber,
                                                          snapshot.data[i]
                                                              .surahNumber
                                                              .toString());
                                                  ayetid = snapshot
                                                      .data[i].verseNumber;
                                                  await ConfigHelper()
                                                      .addSharedOther(
                                                          widget.detail,
                                                          snapshot.data[i]
                                                              .verseNumber);
                                                  setState(() {});
                                                }),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.content_copy,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: snapshot.data[i]
                                                              .translation));
                                                  Flushbar(
                                                    //title: "Hey Ninja",
                                                    message:
                                                        "Ayə uğurla kopyalandı",
                                                    duration:
                                                        Duration(seconds: 3),
                                                  )..show(context);
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                if (ui.arabic)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      snapshot.data[i].text,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontSize: ui.fontSize,
                                        fontFamily: "Uthman",
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  height: 23,
                                ),
                                if (ui.terjemahan)
                                  Column(
                                    children: <Widget>[
                                      AppStyle.spaceH5,
                                      Text(
                                        snapshot.data[i].translation,
                                        //toolbarOptions: ToolbarOptions(
                                        //  copy: true,
                                        //  selectAll: true,
                                        // ),
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: ui.fontSizetext,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 23,
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo[400]),
                ),
              );
      },
    ));
  }
}


*/