// To parse this JSON data, do
//
//     final surah = surahFromJson(jsonString);

import 'dart:convert';

class Surah {
  Surah({
    this.surahNumber,
    this.verseNumber,
    this.text,
    this.translation,
    this.id,
  });
  int id;
  int surahNumber;
  int verseNumber;
  String text;
  String translation;

  factory Surah.fromRawJson(String str) => Surah.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        surahNumber: int.parse(json["surah_number"]),
        verseNumber: int.parse(json["verse_number"]),
        text: json["text"],
        translation: json["translation"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "surah_number": surahNumber,
        "verse_number": verseNumber,
        "text": text,
        "translation": translation,
      };
}
