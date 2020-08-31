import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:quran_app/data/models/allsurah.dart';
import 'package:quran_app/data/models/surah_info.dart';
import 'package:quran_app/data/services.dart';
import 'package:quran_app/data/utils/config_helper.dart';
import 'package:quran_app/ui/widget/cardsurah.dart';

import '../detail_surah.dart';

class ListAllSurah extends StatefulWidget {
  ListAllSurah({Key key}) : super(key: key);

  @override
  _ListAllSurahState createState() => _ListAllSurahState();
}

class _ListAllSurahState extends State<ListAllSurah> {
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
      data.endNumber = await ConfigHelper().getShared(data.index);
    }
    sonsureAdi = await ConfigHelper().getSharedString("sonSureAdi");

    if (sonsureAdi != null) {
      sonsureNo = await ConfigHelper().getShared("sonSureNo");
      sonAyet = await ConfigHelper().getShared(sonsureNo);

      var s = sonAyet;
    }

    setState(() {});
  }

  int number = 0;
  @override
  void initState() {
    super.initState();

    serviceData = ServiceData();
    getSurahInfos();
  }

  @override
  Widget build(BuildContext context) {
    int number = 0;

    return allSurahInfos.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 15, left: 22, right: 22, bottom: 5),
                  child: TextField(
                    autofocus: false,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintText: 'Search ',
                      alignLabelWithHint: false,

                      // filled: true
                    ),
                    onChanged: (text) {
                      if (text == '') {
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
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  child: Text(sonsureAdi == null
                      ? " kaydetmediniz"
                      : "Son Okunan : $sonsureAdi ayah:  $sonsureNo"),
                ),
                ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children: viewSurahList.map((data) {
                      return CardSurah(
                        title: data.latin,
                        subtitle: data.translation,
                        surah: data.index.toString(),
                        ayah: data.ayahCount.toString(),
                        //ayah: number.toString(),
                        arabic: data.arabic.toString(),
                        endnumber:
                            data.endNumber == null ? "yok" : data.endNumber,
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailSurah(
                                        detail: data.latin,
                                        indexx: data.index,
                                        information: data.opening,
                                      )));
                          await getSurahInfos();
                        },
                      );
                    }).toList()),
              ],
            ),
          )
        : PKCardListSkeleton(
            isCircularImage: true,
            isBottomLinesActive: true,
            length: 10,
          );
  }
}
