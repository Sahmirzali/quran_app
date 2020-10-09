// To parse this JSON data, do
//
//     final surah = surahFromJson(jsonString);

import 'dart:convert';

class Surah {
  Surah(
      {this.surahNumber,
      this.verseNumber,
      this.surahName,
      this.text,
      this.translation,
      this.id,
      this.isBookmarked,
      this.idNum});
  int id;
  bool isBookmarked;
  String surahNumber;
  String verseNumber;
  String surahName;
  String text;
  String translation;
  int idNum;

  factory Surah.fromRawJson(String str) => Surah.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        surahNumber: json["surah_number"],
        verseNumber: json["verse_number"],
        surahName: json["surah_name"],
        text: json["text"],
        translation: json["translation"],
        id: json["id"],
        isBookmarked: json["isBookmarked"] == 1,
        idNum: json["idNum"],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'translation': translation,
      'surah_number': surahNumber,
      'verse_number': verseNumber,
      'surah_name': surahName,
      "isBookmarked": isBookmarked ? 1 : 0,
      'idNum': idNum,
    };
  }

  Map<String, dynamic> toJson() => {
        "surah_number": surahNumber,
        "verse_number": verseNumber,
        "text": text,
        "translation": translation,
        "surah_name": surahName,
        "isBookmarked": isBookmarked ? 1 : 0,
        "idNum": idNum,
      };
}
