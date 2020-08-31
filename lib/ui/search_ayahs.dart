import 'package:flutter/material.dart';
import 'package:quran_app/data/DbHelper.dart';
import 'package:quran_app/data/Surah.dart';
import 'package:quran_app/data/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 45),
          Container(
            margin: EdgeInsets.only(top: 15, left: 22, right: 22, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                hintText: 'Search ',
                alignLabelWithHint: false,

                // filled: true
              ),
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
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchhResultList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Column(
                    children: [
                      Text(searchhResultList[index].text),
                      Text(searchhResultList[index].translation),
                    ],
                  ),
                  subtitle:
                      Text(searchhResultList[index].verseNumber.toString()),
                  trailing:
                      Text(searchhResultList[index].surahNumber.toString()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

void a() {
  SurahDatabase db = SurahDatabase();
  Surah surah = Surah();
  surah.text = "";
  db.insertSurah(surah);
}

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

