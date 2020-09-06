import 'dart:convert';


import 'package:quran_app/data/models/allsurah.dart';

import 'package:quran_app/data/models/surah_info.dart';
import 'package:flutter/services.dart';


class ServiceData {
  var infosurah = 'surah/surah-info.json';
  var allSurah = 'surah/allsurah.json';

  Future<List<SurahInfo>> loadInfo() async {
    var response = await rootBundle.loadString(infosurah);
    Iterable data = json.decode(response);
   
    return data.map((model) => SurahInfo.fromJson(model)).toList();
  }

  Future<List<AllSurah>> loadSurah(String surahnum) async {
    //print('alinacak sure:' + surahnum.toString());
    var response = await rootBundle.loadString(allSurah);
    Iterable data = json.decode(response);

    var result = data
        .map((model) {
          return AllSurah.fromJson(model);
        })
        .where((surah) => surah.surahNumber == surahnum)
        .toList();

    //print('result count ' + result.length.toString());
    return result;
  }
}
