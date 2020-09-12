// To parse this JSON data, do
//
//     final surah = surahFromJson(jsonString);

// bu dbden bookmark db sine ayetler gibiyor icona tiklayinca insert ayah
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
      this.idNum
      // this.idNum,
      });
  int id;
  bool isBookmarked;
  String surahNumber;
  String verseNumber;
  String surahName;
  String text;
  String translation;
  int idNum;
  //int idNum;
  //evet hocam hatta ekleyelim 1 dakika

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
        //   idNum: json["idNum"],
      );
// oraya bisey eklersek burada bir problem olmaz ki ?

// Hocam galibe isBookmark i bookmark db sinde olusturmak gerek ?
//hocam orada oluşturursak o zaman bookmark.dart sayfasında nasıl görebilriiz ki
//burası değil de biraz önce bi yer vardı
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
      //  'idNum': idNum,
    }; // burayada ekleyeyim mi ? bu ikisi aynı metot? tamam da aynı işi yapıyorlar neden oluştu diğeri? sqfliteden once json kullaniyordum oradan db ye gidiyordu
    //farklı metot yazmana gerek yok ki sqflite da json tipinde veri alıp gönderiyor tamam hocam anladim
    //şuan tamam gibi görünüyor. veritabanı oluştu
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
