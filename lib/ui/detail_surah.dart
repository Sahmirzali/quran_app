import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:quran_app/data/DbHelper.dart';
import 'package:quran_app/data/Surah.dart';

import 'package:quran_app/data/themes.dart';
import 'package:quran_app/data/uistate.dart';
import 'package:quran_app/data/utils/config_helper.dart';
import 'package:quran_app/data/utils/style.dart';
import 'package:quran_app/ui/settings.dart';

import 'package:path/path.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'dart:async';

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
  List<Surah> ayahList;
  int _kaldigimAyet = 0;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();

    initDb();
    ConfigHelper.getShared(widget.indexx.toString()).then((value) => {
          setState(() {
            ayetid = value;
          }),
        });
  }

  Future initDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'allsurah_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE allsurah(id INTEGER PRIMARY KEY, text TEXT, translation TEXT, surahNumber TEXT, verseNumber TEXT, surahName TEXT)", // bunu diyorum/belki öyledir. düzeltin yine de
        );
      },
      version: 1,
    );

    /* 
     int surahNumber;
    int verseNumber;
    String text;
    String translation;
     */
  }

  Future<void> _kaldigimAyeteGit() async {
    int _kaldigimAyetShared = await ConfigHelper.getkaldigimAyet(widget.indexx);
    _kaldigimAyet = _kaldigimAyetShared != null ? _kaldigimAyetShared : 0;

    print("çalıştı mı kontrol ediyoruz..");
    if (_kaldigimAyet != 0) {
      print("kaldığım ayet: $_kaldigimAyet");
      itemScrollController.jumpTo(
        index: _kaldigimAyet,
        //duration: Duration(seconds: 1),
      );
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
    var titleColor = 0xff803BE2;
    return Scaffold(
        //backgroundColor: Colors.white,
        body: FutureBuilder<List<Surah>>(
      future: SurahDatabase().getSurahList(widget.indexx),
      builder: (c, snapshot) {
        if (snapshot.hasData) {
          ayahList = snapshot.data;
        }
        return snapshot.hasData
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Scrollbar(
                      child: ScrollablePositionedList.builder(
                          itemScrollController: itemScrollController,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int i) {
                            return i == 0
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 40.0,
                                            bottom: 16,
                                            left: 2,
                                            right: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.keyboard_backspace),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                ),
                                                Text(
                                                  "${widget.detail} surəsi",
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 20 * textScale,
                                                    fontWeight: FontWeight.w600,
                                                    color: thememode.darkmode
                                                        ? Colors.white
                                                        : Color(titleColor),
                                                    //color: Colors.deepPurple[900],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.arrow_downward),
                                                  onPressed: () {
                                                    _kaldigimAyeteGit();
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.more_vert),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Settings()));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                widget.detail == null
                                                    ? " "
                                                    : "${widget.detail}",
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
                                                widget.type == null
                                                    ? " "
                                                    : widget.type,
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
                                                widget.ayahcount.toString() ==
                                                        null
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.33334,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.86888,

                                        //height: MediaQuery.of(context).size.height - 420.0,
                                        //width: MediaQuery.of(context).size.width - 49.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(19),
                                            //color: Colors.blue,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "images/lastayah.jpg"),
                                                fit: BoxFit.fill)),
                                      ),
                                      SizedBox(height: 15),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 7.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: thememode.darkmode
                                                      ? Color(0xff152451)
                                                      : Color(0xFF863ED5)
                                                          .withOpacity(
                                                              0.055433222222),
                                                  //color: Color(0xFF863ED5)
                                                  //  .withOpacity(0.055433222222),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              //color: Colors.grey,
                                              height: 47,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16, right: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    //SizedBox(width: 0,),

                                                    Text(
                                                      snapshot
                                                          .data[i].verseNumber,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        //color:Colors.black87,
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                            icon: Icon(
                                                              snapshot.data[i]
                                                                          .isBookmarked ==
                                                                      true
                                                                  ? Icons
                                                                      .bookmark
                                                                  : Icons
                                                                      .bookmark_border,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await SurahDatabase()
                                                                  .setBookmark(
                                                                      snapshot.data[
                                                                          i],
                                                                      !snapshot
                                                                          .data[
                                                                              i]
                                                                          .isBookmarked);
                                                              setState(() {});
                                                            }),
                                                        IconButton(
                                                            icon: Icon(
                                                              snapshot.data[i]
                                                                          .verseNumber ==
                                                                      ayetid
                                                                  ? Icons
                                                                      .favorite
                                                                  : Icons
                                                                      .favorite_border,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await ConfigHelper.addShared(
                                                                  snapshot
                                                                      .data[i]
                                                                      .verseNumber,
                                                                  snapshot
                                                                      .data[i]
                                                                      .surahNumber
                                                                      .toString());
                                                              ayetid = snapshot
                                                                  .data[i]
                                                                  .verseNumber;

                                                              await ConfigHelper
                                                                  .addSharedOther(
                                                                      widget
                                                                          .detail,
                                                                      snapshot
                                                                          .data[
                                                                              i]
                                                                          .verseNumber);
                                                              await ConfigHelper
                                                                  .kaldigimAyet(
                                                                      widget
                                                                          .indexx,
                                                                      i);

                                                              setState(() {});
                                                            }),
                                                        IconButton(
                                                            icon: Icon(
                                                              Icons
                                                                  .content_copy,
                                                            ),
                                                            onPressed: () {
                                                              Clipboard.setData(
                                                                  ClipboardData(
                                                                      text: snapshot
                                                                          .data[
                                                                              i]
                                                                          .translation));
                                                              Flushbar(
                                                                //title: "Hey Ninja",
                                                                message:
                                                                    "Ayə uğurla kopyalandı",
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            3),
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
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  snapshot.data[i].text,
                                                  textDirection:
                                                      TextDirection.rtl,
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
                                                    snapshot
                                                        .data[i].translation,
                                                    //toolbarOptions: ToolbarOptions(
                                                    //  copy: true,
                                                    //  selectAll: true,
                                                    // ),
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: ui.fontSizetext,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 7.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: thememode.darkmode
                                                  ? Color(0xff152451)
                                                  : Color(0xFF863ED5)
                                                      .withOpacity(
                                                          0.055433222222),
                                              //color: Color(0xFF863ED5)
                                              //  .withOpacity(0.055433222222),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          //color: Colors.grey,
                                          height: 47,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data[i].verseNumber,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    // color: Colors.black87,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        icon: Icon(
                                                          snapshot.data[i]
                                                                      .isBookmarked ==
                                                                  true
                                                              ? Icons.bookmark
                                                              : Icons
                                                                  .bookmark_border,
                                                        ),
                                                        onPressed: () async {
                                                          await SurahDatabase()
                                                              .setBookmark(
                                                                  snapshot
                                                                      .data[i],
                                                                  !snapshot
                                                                      .data[i]
                                                                      .isBookmarked);
                                                          setState(() {});
                                                          /* insertAyah(
                                                              snapshot.data[i]);*/
                                                        }),
                                                    IconButton(
                                                        icon: Icon(
                                                          snapshot.data[i]
                                                                      .verseNumber ==
                                                                  ayetid
                                                              ? Icons.favorite
                                                              : Icons
                                                                  .favorite_border,
                                                        ),
                                                        onPressed: () async {
                                                          await ConfigHelper.addShared(
                                                              snapshot.data[i]
                                                                  .verseNumber,
                                                              snapshot.data[i]
                                                                  .surahNumber
                                                                  .toString());
                                                          ayetid = snapshot
                                                              .data[i]
                                                              .verseNumber;
                                                          await ConfigHelper
                                                              .addSharedOther(
                                                                  widget.detail,
                                                                  snapshot
                                                                      .data[i]
                                                                      .verseNumber);
                                                          await ConfigHelper
                                                              .kaldigimAyet(
                                                                  widget.indexx,
                                                                  i);

                                                          setState(() {});
                                                        }),
                                                    IconButton(
                                                        icon: Icon(
                                                          Icons.content_copy,
                                                        ),
                                                        onPressed: () {
                                                          Clipboard.setData(
                                                              ClipboardData(
                                                                  text: snapshot
                                                                      .data[i]
                                                                      .translation));
                                                          Flushbar(
                                                            //title: "Hey Ninja",
                                                            message:
                                                                "Ayə uğurla kopyalandı",
                                                            duration: Duration(
                                                                seconds: 3),
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
                                                textDirection:
                                                    TextDirection.ltr,
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
                    ),
                  ),
                  //bir problem olmaz bence de ya
                  SizedBox(
                    height: 23,
                  ),
                ],
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
