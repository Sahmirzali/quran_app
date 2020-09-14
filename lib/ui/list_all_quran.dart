import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/data/themes.dart';
import 'package:quran_app/ui/about.dart';
import 'package:quran_app/ui/detail_surah.dart';
import 'package:flutter/services.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:quran_app/data/models/surah_info.dart';
import 'package:quran_app/data/services.dart';
import 'package:quran_app/data/utils/config_helper.dart';
import 'package:quran_app/ui/widget/cardsurah.dart';

class ListAllSurah extends StatefulWidget {
  @override
  _ListAllSurahState createState() => _ListAllSurahState();
}

class _ListAllSurahState extends State<ListAllSurah>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<SurahInfo> allSurahInfos = new List();
  List<SurahInfo> serachResultList = new List();
  List<SurahInfo> viewSurahList = new List();
  ServiceData serviceData;
  String sonsureAdi;
  String sonsureNo;
  String sonAyet;

  getSurahInfos() async {
    allSurahInfos = await serviceData.loadInfo();
    viewSurahList = allSurahInfos;
    for (var data in viewSurahList) {
      data.endNumber = await ConfigHelper.getShared(data.index);
    }
    sonsureAdi = await ConfigHelper.getSharedString("sonSureAdi");

    if (sonsureAdi != null) {
      sonsureNo = await ConfigHelper.getShared("sonSureNo");
      sonAyet = await ConfigHelper.getShared(sonsureNo);

      var s = sonAyet;
    }

    setState(() {});
  }

  int number = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);

    serviceData = ServiceData();
    getSurahInfos();
  }

  final String assetName = 'images/lastread.svg';
  final TextEditingController _textController = new TextEditingController();

  TabController _tabController;

  /*@override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  } */

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var thememode = Provider.of<ThemeNotifier>(context);
    var titleColor = 0xff803BE2;
    var screenSize = MediaQuery.of(context).size;
    var textScale = MediaQuery.of(context).textScaleFactor;

    return allSurahInfos.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 39, left: 20, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Qurani kərim",

                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20 * textScale,
                              fontWeight: FontWeight.w600,
                              color: thememode.darkmode
                                  ? Colors.white
                                  : Color(titleColor),
                              //color: Color(titleColor),
                            ),
                            //color: Color(titleColor),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => About()));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 13, right: 13, bottom: 11),
                  child: SizedBox(
                    //height: 139.4,
                    //width: double.infinity,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            child: Image.asset(
                              'images/sonoxunan.jpg',
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height / 15.8,
                            left: MediaQuery.of(context).size.width / 17,
                            child: Text(
                              sonsureAdi == null ? " " : "$sonsureAdi",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 19 * textScale,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height / 29.5,
                            left: MediaQuery.of(context).size.width / 17,
                            child: Text(
                              sonsureAdi == null ? "" : "Ayə no:  $sonsureNo",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15 * textScale,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /* Container(
                  child: Text(sonsureAdi == null
                      ? " kaydetmediniz"
                      : "Son Okunan : $sonsureAdi ayah:  $sonsureNo"),
                ),
                SizedBox(
                  height: 10,
                ), */
                GestureDetector(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
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
                                    viewSurahList = allSurahInfos;
                                  });
                                })
                            : new Container(
                                height: 0.0,
                              ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 25.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        hintText: "Surələr üzrə axtar",
                        alignLabelWithHint: false,
                        filled: false,
                      ),
                      onChanged: (text) {
                        if (text.isEmpty) {
                          viewSurahList = allSurahInfos;
                        } else {
                          serachResultList.clear();
                          allSurahInfos.forEach((e) {
                            if (e.latin
                                .toLowerCase()
                                .contains(text.toLowerCase()))
                              serachResultList.add(e);
                          });

                          setState(() {
                            viewSurahList = serachResultList;
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
                  height: 16,
                ),
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children: viewSurahList.map((data) {
                      return CardSurah( //bir widget bu CardSurah gibi çook tekrar edecekse evet bu mantıklı
                        title: data.latin,
                        subtitle: data.type,
                        surah: data.index.toString(),
                        ayah: data.ayahCount.toString(),
                        //ayah: number.toString(),
                        arabic: data.arabic,
                        endnumber: data.endNumber == null ? "" : data.endNumber,
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailSurah(
                                        detail: data.latin,
                                        indexx: data.index,
                                        information: data.type,
                                        type: data.type,
                                        ayahcount: data.ayahCount,
                                        endnumber: data.endNumber,
                                      )));
                          await getSurahInfos();
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 2,
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
  }

  @override
  bool get wantKeepAlive => true;
}
