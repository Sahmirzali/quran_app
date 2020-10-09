import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UiState extends ChangeNotifier {
  SharedPreferences prefs;
  SharedPreferences prefs1;
  bool erebce;
  bool translate;

  double ayahsize;
  double textsize;

  UiState() {
    erebce = true;
    _loadFromPrefs();
    translate = false;
    _loadFromPrefs2();
    ayahsize = 10;
    _loadFromPrefs3();
    textsize = 10;
    _loadFromPrefs4();
  }

  //static bool translate = false;

  set fontSize(newValue) {
    ayahsize = newValue;
    _saveToPrefs3();
    notifyListeners();
  }

  _loadFromPrefs3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ayahsize = prefs.getDouble("ayahsize") ?? 41;

    notifyListeners();
  }

  _saveToPrefs3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("ayahsize", ayahsize);
  }

  double get fontSize => ayahsize;

  set fontSizetext(newValue1) {
    textsize = newValue1;
    _saveToPrefs4();
    notifyListeners();
  }

  _loadFromPrefs4() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    textsize = prefs1.getDouble("textsize") ?? 16;

    notifyListeners();
  }

  _saveToPrefs4() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setDouble("textsize", textsize);
  }

  double get fontSizetext => textsize;

  bool get arabic => erebce;
  set arabic(newValue) {
    erebce = newValue;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    erebce = prefs.getBool("switchState1") ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool("switchState1", erebce);
  }

  bool get terjemahan => translate;
  set terjemahan(newValue) {
    translate = newValue;
    _saveToPrefs2();
    notifyListeners();
  }

  _initPrefs2() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs2() async {
    await _initPrefs2();
    translate = prefs.getBool("switchState2") ?? true;
    notifyListeners();
  }

  _saveToPrefs2() async {
    await _initPrefs2();
    prefs.setBool("switchState2", translate);
  }
}
