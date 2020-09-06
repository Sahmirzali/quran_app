// To parse this JSON data, do
//
//     final surah = surahFromJson(jsonString);

import 'dart:convert';

class Surah {
  Surah({
    this.surahNumber,
    this.verseNumber,
    this.surahName,
    this.text,
    this.translation,
    this.id,
  });
  int id;
  String surahNumber;
  String verseNumber;
  String surahName;
  String text;
  String translation;

  factory Surah.fromRawJson(String str) => Surah.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        surahNumber: json["surah_number"],
        verseNumber: json["verse_number"],
        surahName: json["surah_name"],
        text: json["text"],
        translation: json["translation"],
        id: json["id"],
      );

      Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'translation': translation,
      'surahName': surahName,
      'surahNumber': surahNumber,
      'verseNumber': verseNumber,
    };
  }
  // hocam null o shared prefden :)  olusmamis tekrar basmak gerek hocam bisey soylicem
  // bu bende bazi ayetler mealda birlesik oldugu icin int tutmak olmuyor, o yuzden string tutuyorum
  Map<String, dynamic> toJson() => {
        "surah_number": surahNumber,
        "verse_number": verseNumber,
        "text": text,
        "translation": translation,
        "surah_name": surahName
      };
}
