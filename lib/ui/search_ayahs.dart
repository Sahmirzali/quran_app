import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/data/DbHelper.dart';
import 'package:quran_app/data/Surah.dart';
import 'package:quran_app/data/services.dart';
import 'package:quran_app/data/uistate.dart';
import 'package:quran_app/data/utils/style.dart';
import 'package:quran_app/ui/settings.dart';

class Search_Ayahs extends StatefulWidget {
  Search_Ayahs({Key key}) : super(key: key);

  @override
  _Search_AyahsState createState() => _Search_AyahsState();
}

class _Search_AyahsState extends State<Search_Ayahs> {
  List<Surah> searchhResultList = [];
  ServiceData serviceData;
  SurahDatabase db = SurahDatabase();

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _textController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var textScale = MediaQuery.of(context).textScaleFactor;
    var ui = Provider.of<UiState>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 43,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Axtarış səhifəsi",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20 * textScale,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple[900]),
                  ),
                ],
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
          SizedBox(height: 12),
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
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 10.0),
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
                  } else if (text.length >= 3) {
                    searchhResultList = await db.searchSurah(text);
                    // var a = await db.allSurah();
                    setState(() {});
                  }
                },
                controller: _textController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchhResultList.length,
            itemBuilder: (BuildContext context, int i) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF863ED5).withOpacity(0.0666666),
                          borderRadius: BorderRadius.circular(10)),
                      //color: Colors.grey,
                      height: 47,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //SizedBox(width: 0,),

                            Text(
                              "${searchhResultList[i].surahNumber}.${searchhResultList[i].surahName} ${searchhResultList[i].verseNumber} ayə",
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
                                      Icons.content_copy,
                                    ),
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                          text:
                                              searchhResultList[i].translation,
                                        ),
                                      );
                                      Flushbar(
                                        //title: "Hey Ninja",
                                        message: "Ayə uğurla kopyalandı",
                                        duration: Duration(seconds: 3),
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
                    SizedBox(
                      height: 20,
                    ),
                    if (ui.terjemahan)
                      Column(
                        children: <Widget>[
                          AppStyle.spaceH5,
                          Text(
                            searchhResultList[i].translation,
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
            },
          ),
        ],
      ),
    );
  }
}

/* 
ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchhResultList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Column(
                    children: [
                      Text(searchhResultList[i].text),
                      Text(searchhResultList[i].translation),
                    ],
                  ),
                  subtitle:
                      Text(searchhResultList[i].verseNumber.toString()),
                  trailing:
                      Text(searchhResultList[i].surahNumber.toString()),
                ),
              );
            },
          ),
*/

/*
onChanged: (text) async {
               
                if (text == '') {
                  searchhResultList.clear();
                  setState(() {});
                } else if (text.length > 3) {
                  searchhResultList = await db.searchSurah(text);
                  // var a = await db.allSurah();
                  setState(() {});
                }
              },
              */

/*void a() {
  SurahDatabase db = SurahDatabase();
  Surah surah = Surah();
  surah.text = "";
  db.insertSurah(surah);
}

*/
/* var str =
                      await rootBundle.loadString("assets/json/data.json");

                  var b = jsonDecode(str) as List<dynamic>;
                  List<Surah> list = b
                      .map((e) => Surah.fromJson(e as Map<String, dynamic>))
                      .toList();
                  await db.deletelall();
                  print(list.length);
                  int ss = 0;
                  for (var a in list) {
                    ss++;
                    print(ss);
                    await db.insertSurah(a);
                  }*/
