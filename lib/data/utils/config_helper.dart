import 'package:shared_preferences/shared_preferences.dart';

class ConfigHelper {
  static Future<void> addShared(String ayet_id, String sure_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(sure_id, ayet_id);
  }

  static Future<void> kaldigimAyet(String sureID, int kaldigimAyet) async {
    int _sureID = int.parse(sureID);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('kaldigimAyet_$_sureID', kaldigimAyet);
  }

  static Future<void> setKaldigimSure(int sureListIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('kaldigimSure', sureListIndex);
  }

  static Future<int> getKaldigimSure() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('kaldigimSure');
  }


  static Future<int> getkaldigimAyet(String sureID) async {
    int _sureID = int.parse(sureID);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('kaldigimAyet_$_sureID');
  }

  static Future<void> addSharedOther(String sureadi, String sure_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sonSureAdi', sureadi);
    await prefs.setString('sonSureNo', sure_id);
  }

  static Future<String> getShared(String sureno) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sureno);
  }

  static Future<String> getSharedString(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }
}
