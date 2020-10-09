import 'dart:convert';

List<SurahInfo> surahInfoFromJson(String str) =>
    List<SurahInfo>.from(json.decode(str).map((x) => SurahInfo.fromJson(x)));

String surahInfoToJson(List<SurahInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SurahInfo {
  String arabic;
  String latin;
  int ayahCount;
  String index;
  String type;
  String endNumber;


  SurahInfo({
    this.arabic,
    this.latin,
    this.ayahCount,
    this.index,
    this.type,
    this.endNumber
  });

  factory SurahInfo.fromJson(Map<String, dynamic> json) => SurahInfo(
        arabic: json["arabic"] == null ? null : json["arabic"],
        latin: json["latin"] == null ? null : json["latin"],
        ayahCount: json["ayah_count"] == null ? null : json["ayah_count"],
        index: json["index"] == null ? null : json["index"],
        type: json["type"] == null ? null : json["type"],
        endNumber: json["endNumber"] == null ? null : json["endNumber"],
      );

  Map<String, dynamic> toJson() => {
        "arabic": arabic == null ? null : arabic,
        "latin": latin == null ? null : latin,
        "ayah_count": ayahCount == null ? null : ayahCount,
        "index": index == null ? null : index,
        "type": type == null ? null : type,
        "endNumber": endNumber == null ? null : endNumber,
      };
}

