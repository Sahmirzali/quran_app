import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/data/DbHelper.dart';
import 'package:quran_app/data/Surah.dart';
import 'package:quran_app/data/themes.dart';
import 'package:quran_app/data/uistate.dart';
import 'package:quran_app/data/utils/style.dart';
import 'package:quran_app/ui/settings.dart';

class Bookmark extends StatefulWidget {
  Bookmark({Key key}) : super(key: key);

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  var database;
  List<Surah> allsurah = [];
  SurahDatabase db = new SurahDatabase();
  @override
  void initState() {
    super.initState();
    getBookmarkList();
  }

  @override
  Widget build(BuildContext context) {
    var thememode = Provider.of<ThemeNotifier>(context);
    var colorBook = 0xff1D1729;
    var titleColor = 0xff803BE2;
    var cardColor = 0xffEEDEFF;
    var textScale = MediaQuery.of(context).textScaleFactor;
    return SingleChildScrollView(
      child: Column(
        children: [
         
          Padding(
            padding: const EdgeInsets.only(top: 47,left: 20,bottom: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                   
                    Text(
                      "Seçilən ayələr",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20 * textScale,
                        fontWeight: FontWeight.w600,
                        color: thememode.darkmode
                                  ? Colors.white
                                  : Color(titleColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: allsurah.length,
                itemBuilder: (context, index) {
                  var allsurahdata = allsurah[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 0, bottom: 5),
                    child: Card(
                      shadowColor: Color(cardColor),
                      color: Colors.deepPurple[50],
                      //.withOpacity(0.0666666),

                      elevation: 2.2,

                      //shadowColor: Colors.grey,
                      child: ListTile(
                        // leading: Text(" "),
                        title: Text(
                          //burada nasil vercem peki hocam
                          //getBookmarks ilemi ? toMap falan mi ? yapcam ? o sana surah list dönüyor sadece ekranda göstereceksin o kadar
                          //vazgeçtim kalmasın otomatik id oluşutor zaten .. hocam bu bookmark sayfasinda boyle nasil gostercem anlamadim
                          " ${allsurahdata.surahNumber}. ${allsurahdata.surahName} surəsi ${allsurahdata.verseNumber} ayə",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15 * textScale,
                            fontWeight: FontWeight.w500,
                            color: (Colors.black87),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => _onShowDialog(
                                    context,
                                    '${allsurahdata.surahNumber}',
                                    '${allsurahdata.verseNumber}',
                                    '${allsurahdata.text}',
                                    '${allsurahdata.translation}',
                                  ));
                        },
                        trailing: IconButton(
                          color: Colors.deepPurple,
                          onPressed: () async {
                            await db.setBookmark(allsurahdata, false);

                            getBookmarkList();
                            //veritabanını oluştur %90 çalışır sorunsuz veritabani varya nasil yani olustur ? column eksik
                            //
                          },
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: Color(titleColor),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  _onShowDialog(BuildContext context, String surahnumber, String ayahnumber,
      String text, String translation) {
    var textScale = MediaQuery.of(context).textScaleFactor;
    var mysize = MediaQuery.of(context).size;
    var thememode = Provider.of<ThemeNotifier>(context);
    var ui = Provider.of<UiState>(context);
    debugPrint(text.length.toDouble().toString());
    debugPrint(translation.length.toDouble().toString());
    debugPrint((text.length + translation.length).toString());
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: mysize.height * 0.78,
            minHeight: mysize.height * 0.37,
          ),
          child: Container(
            color: thememode.darkmode ? Color(0xff091945) : Colors.white,
            height:
                _status(text.length.toDouble(), translation.length.toDouble()),
            //height: text.length.toDouble() + translation.length.toDouble() + 140,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff8539F3),
                      //color: Color(0xFF863ED5).withOpacity(0.17),
                      borderRadius: BorderRadius.circular(0)),
                  //color: Colors.grey,
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          IconButton(
                                        icon: Icon(
                                          Icons.content_copy,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: translation,
                                            ),
                                          );
                                          Flushbar(
                                            //title: "Hey Ninja",
                                            message: "Ayə uğurla kopyalandı",
                                            duration: Duration(seconds: 3),
                                          )..show(context);
                                        }),
                        
                        Text(
                          surahnumber + " : " + ayahnumber,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.5 * textScale,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Settings()));
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 7, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          if (ui.arabic)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                text,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: ui.fontSize,
                                  fontFamily: 'Uthman',
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
                                  translation,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: ui.fontSizetext,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff8539F3),
                      //color: Color(0xFF863ED5).withOpacity(0.17),
                      borderRadius: BorderRadius.circular(0)),
                  //color: Colors.grey,
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _status(var text, var translation) {
    if (text + translation > 165) {
      return text + translation + 175;
    } else if (text + translation < 150) {
      return text + translation + 145;
    } else if (150 < text + translation || 165 > text + translation) {
      return text + translation + 140;
    }
  }

  Future<void> getBookmarkList() async {
    allsurah = await db.getBookmarks();
    setState(() {});
  }
}

