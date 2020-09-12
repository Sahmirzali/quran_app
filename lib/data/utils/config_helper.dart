import 'package:shared_preferences/shared_preferences.dart';

class ConfigHelper {
  Future<void> addShared(String ayet_id, String sure_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(sure_id, ayet_id);
  }

  Future<void> addSharedOther(String sureadi, String sure_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sonSureAdi', sureadi);
    await prefs.setString('sonSureNo', sure_id);
  }

  Future<String> getShared(String sureno) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sureno);
  }

  Future<String> getSharedString(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }
}
