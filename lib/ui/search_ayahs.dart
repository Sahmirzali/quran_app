import 'package:dynamic_text_highlighting/dynamic_text_highlighting.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/data/DbHelper.dart';
import 'package:quran_app/data/Surah.dart';
import 'package:quran_app/data/services.dart';
import 'package:quran_app/data/themes.dart';
import 'package:quran_app/data/uistate.dart';
import 'package:quran_app/data/utils/style.dart';
import 'package:quran_app/ui/settings.dart';

class Search_Ayahs extends StatefulWidget {
  Search_Ayahs({Key key}) : super(key: key);

  @override
  _Search_AyahsState createState() => _Search_AyahsState();
}

class _Search_AyahsState extends State<Search_Ayahs>
    with AutomaticKeepAliveClientMixin {
  List<Surah> searchhResultList = [];
  List<String> highlights = [];
  ServiceData serviceData;
  SurahDatabase db = SurahDatabase();

  @override
  void initState() {
    super.initState();
  }

  final ScrollController _arrowsController = ScrollController();
  final TextEditingController _textController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var thememode = Provider.of<ThemeNotifier>(context);
    var titleColor = 0xff803BE2;
    var textScale = MediaQuery.of(context).textScaleFactor;
    var ui = Provider.of<UiState>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 39, left: 20, right: 8, bottom: 8.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Axtarış səhifəsi",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20 * textScale,
                  fontWeight: FontWeight.w600,
                  color: thememode.darkmode ? Colors.white : Color(titleColor),
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              )
            ],
          ),
        ),
        //SizedBox(height: 12),
        GestureDetector(
          child: Container(
            height: 50,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: _textController.text.length >= 0
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _textController.clear();
                            searchhResultList.clear();
                          });
                        })
                    : new Container(
                        height: 0.0,
                      ),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                hintText: "Ayələr üzrə axtar",
                alignLabelWithHint: false,
                filled: false,
              ),
              onChanged: (text) async {
                if (text == '') {
                  searchhResultList.clear();
                  setState(() {});
                } else if (text.length >= 2) {
                  searchhResultList = await db.searchSurah(text);
                  // var a = await db.allSurah();

                  setState(() {
                    highlights = [text];
                  });

            
                }
              },
              controller: _textController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _arrowsController,
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                      controller: _arrowsController,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: searchhResultList.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 7.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: thememode.darkmode
                                        ? Color(0xff152451)
                                        : Color(0xFF863ED5)
                                            .withOpacity(0.055433222222),
                                    borderRadius: BorderRadius.circular(10)),
                                //color: Colors.grey,
                                height: 47,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, right: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //SizedBox(width: 0,),

                                      Text(
                                        "${searchhResultList[i].surahNumber}.${searchhResultList[i].surahName} surəsi ${searchhResultList[i].verseNumber} ayə",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          //color: Colors.black87,
                                          color: thememode.darkmode
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),

                                      SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.content_copy,
                                              ),
                                              onPressed: () {
                                                Clipboard.setData(
                                                  ClipboardData(
                                                    text: searchhResultList[i]
                                                        .translation,
                                                  ),
                                                );
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
                                    searchhResultList[i].text,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: ui.fontSize,
                                      fontFamily: 'Uthman',
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              /* SizedBox(
                          height: 20,
                        ),*/
                              if (ui.terjemahan)
                                Column(
                                  children: <Widget>[
                                    AppStyle.spaceH5,
                                    DynamicTextHighlighting(
                                      caseSensitive: false,
                                      color: Colors.deepPurple[300],
                                      text: searchhResultList[i].translation,
                                      highlights: highlights,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: thememode.darkmode
                                            ? Colors.white
                                            : Colors.black,
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
                      },
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
