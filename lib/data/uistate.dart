import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quran_app/ui/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiState extends ChangeNotifier {
  SharedPreferences prefs;
  bool erebce;
  bool translate;

  static double ayahsize = 1;
  static double textsize = 0.4;

  UiState() {
    erebce = true;
    _loadFromPrefs();
    translate = false;
    _loadFromPrefs2();
  }


  //static bool translate = false;
 

  set fontSize(newValue) {
    ayahsize = newValue;

    notifyListeners();
  }

  double get fontSize => ayahsize * 40;
  double get sliderFontSize => ayahsize;

  set fontSizetext(newValue) {
    textsize = newValue;
    notifyListeners();
  }

  double get fontSizetext => textsize * 35;
  double get sliderFontSizetext => textsize;

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
