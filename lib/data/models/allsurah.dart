// To parse this JSON data, do
//
//     final allSurah = allSurahFromJson(jsonString);

import 'dart:convert';

List<AllSurah> allSurahFromJson(String str) =>
    List<AllSurah>.from(json.decode(str).map((x) => AllSurah.fromJson(x)));

String allSurahToJson(List<AllSurah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllSurah {
  AllSurah(
      {this.surahNumber,
      this.verseNumber,
      this.text,
      this.translation,
      this.id,
      this.surahName});

  String surahNumber;
  String verseNumber;
  String surahName;
  String text;
  String translation;
  int id;


  factory AllSurah.fromJson(Map<String, dynamic> json) => AllSurah(
        surahNumber: json["surah_number"] == null ? null : json["surah_number"],
        verseNumber: json["verse_number"] == null ? null : json["verse_number"],
        surahName: json["surah_name"] == null ? null : json["surah_name"],
        text: json["text"] == null ? null : json["text"],
        translation: json["translation"] == null ? null : json["translation"],
      );

  Map<String, dynamic> toMap() {
    return {
      'surah_name': surahName,
      'id': id,
      'text': text,
      'translation': translation,
      'surahNumber': surahNumber,
      'verseNumber': verseNumber,
    };
  }

   Map<String, dynamic> toJson() => {
        "surah_number": surahNumber == null ? null : surahNumber,
        "verse_number": verseNumber == null ? null : verseNumber,
        "surah_name": surahName == null ? null : surahName,
        "text": text == null ? null : text,
        "translation": translation == null ? null : translation,
    };
}

