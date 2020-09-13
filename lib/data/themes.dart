import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  SharedPreferences prefs;
  bool _darkmode;

  ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Color(0xffFCFFFE),
    toggleableActiveColor: Color(0xffA44AFF),
    sliderTheme: SliderThemeData(
      activeTrackColor: Color(0xffA44BFF),
      inactiveTrackColor: Color(0xffCF9FFF),
      thumbColor: Color(0xffA44AFF),
    ),
  );
  ThemeData dark = ThemeData(
    primarySwatch: MaterialColor(0xff091945, {
      50: Color(0xffeceef8),
      100: Color(0xffd9ddf2),
      200: Color(0xffb3bbe5),
      300: Color(0xff8e98d7),
      400: Color(0xff6876ca),
      500: Color(0xff4254bd),
      600: Color(0xff354397),
      700: Color(0xff283271),
      800: Color(0xff1a224c),
      900: Color(0xff0d1126)
    }),
    brightness: Brightness.dark,
    primaryColor: Color(0xff252f6a),
    primaryColorBrightness: Brightness.dark,
    primaryColorLight: Color(0xff091945),
    primaryColorDark: Color(0xffb3bbe5),
    accentColor: Color(0xffb3bbe5),
    accentColorBrightness: Brightness.dark,
    canvasColor: Color(0xff091945),
    scaffoldBackgroundColor: Color(0xff091945),
    bottomAppBarColor: Color(0xffffffff),
    cardColor: Color(0xff091945),
    dividerColor: Color(0xffd9ddf2),
    highlightColor: Color(0x66bcbcbc),
    splashColor: Color(0x66c8c8c8),
    selectedRowColor: Color(0xfff5f5f5),
    unselectedWidgetColor: Color(0xffffffff),
    disabledColor: Color(0xffffffff),
    buttonColor: Color(0xffe0e0e0),
    toggleableActiveColor: Color(0xffb3bbe5),
    secondaryHeaderColor: Color(0xffeceef8),
    textSelectionColor: Color(0xffb3bbe5),
    cursorColor: Color(0xff4285f4),
    textSelectionHandleColor: Color(0xff8e98d7),
    backgroundColor: Color(0xffb3bbe5),
    dialogBackgroundColor: Color(0xffffffff),
    indicatorColor: Color(0xff4254bd),
    hintColor: Color(0xffffffff),
    errorColor: Color(0xffd32f2f),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      minWidth: 88,
      height: 36,
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xffffffff),
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      alignedDropdown: false,
      buttonColor: Color(0xffe0e0e0),
      disabledColor: Color(0xffffffff),
      highlightColor: Color(0xffffffff),
      splashColor: Color(0xffffffff),
      focusColor: Color(0xffffffff),
      hoverColor: Color(0xffffffff),
      colorScheme: ColorScheme(
        primary: Color(0xffb3bbe5),
        primaryVariant: Color(0xffb3bbe5),
        secondary: Color(0xffb3bbe5),
        secondaryVariant: Color(0xffb3bbe5),
        surface: Color(0xffffffff),
        background: Color(0xffb3bbe5),
        error: Color(0xffd32f2f),
        onPrimary: Color(0xffffffff),
        onSecondary: Color(0xffffffff),
        onSurface: Color(0xffffffff),
        onBackground: Color(0xffffffff),
        onError: Color(0xffffffff),
        brightness: Brightness.light,
      ),
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Color(0xffffffff),
      ),
      bodyText1: TextStyle(
        color: Color(0xffffffff),
      ),
      bodyText2: TextStyle(
        color: Color(0xffffffff),
      ),
      headline4: TextStyle(
        color: Color(0xffffffff),
      ),
      overline: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      helperStyle: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      hintStyle: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorStyle: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorMaxLines: null,
      hasFloatingPlaceholder: true,
      isDense: false,
      contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
      isCollapsed: false,
      prefixStyle: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      suffixStyle: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      counterStyle: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      filled: false,
      fillColor: Color(0x00000000),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffffffff),
          // width: 1,
          //  style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffffffff),
          // width: 1,
          //style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffffffff),
          // width: 1,
          //style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffffffff),
          //width: 1,
          //style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffffffff),
          // width: 1,
          //style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffffffff),
          //width: 1,
          //style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0xffffffff),
      opacity: 1,
      size: 24,
    ),
    primaryIconTheme: IconThemeData(
      color: Color(0xffffffff),
      opacity: 1,
      size: 24,
    ),
    accentIconTheme: IconThemeData(
      color: Color(0xffffffff),
      opacity: 1,
      size: 24,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Color(0xff6876ca),
      inactiveTrackColor: Color(0xff8e98d7),
      disabledActiveTrackColor: Color(0xff091945),
      disabledInactiveTrackColor: Color(0xff091945),
      activeTickMarkColor: Color(0xffffffff),
      inactiveTickMarkColor: Color(0xff091945),
      disabledActiveTickMarkColor: Color(0xff091945),
      disabledInactiveTickMarkColor: Color(0xff091945),
      thumbColor: Color(0xffffffff),
      disabledThumbColor: Color(0xff091945),
      thumbShape: null,
      overlayColor: Color(0xff091945),
      valueIndicatorColor: Color(0xff091945),
      valueIndicatorShape: null,
      showValueIndicator: null,
      valueIndicatorTextStyle: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Color(0xffffffff),
      unselectedLabelColor: Color(0xb2ffffff),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Color(0x1f000000),
      brightness: Brightness.light,
      deleteIconColor: Color(0xde000000),
      disabledColor: Color(0x0c000000),
      labelPadding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
      labelStyle: TextStyle(
        color: Color(0xde000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
      secondaryLabelStyle: TextStyle(
        color: Color(0x3d000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      secondarySelectedColor: Color(0x3d252f6a),
      selectedColor: Color(0x3d000000),
      shape: StadiumBorder(
          side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      )),
    ),
    dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    )),
  );

//091945

  void switchTheme() {
    _darkmode = !_darkmode;
    _saveToPrefsdark();
    notifyListeners();
  }

  ThemeNotifier() {
    _darkmode = true;
    _loadFromPrefsdark();
  }

  _initPrefsdark() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefsdark() async {
    await _initPrefsdark();
    _darkmode = prefs.getBool("switchDarkMode") ?? false;
    notifyListeners();
  }

  _saveToPrefsdark() async {
    await _initPrefsdark();
    prefs.setBool("switchDarkMode", _darkmode);
  }

  bool get darkmode => _darkmode;
}

/*

primarySwatch: MaterialColor(0xff6876ca, {
        50: Color(0xffeceef8),
        100: Color(0xffffffff),
        200: Color(0xffb3bbe5),
        300: Color(0xff8e98d7),
        400: Color(0xff6876ca),
        500: Color(0xff4254bd),
        600: Color(0xff354397),
        700: Color(0xff283271),
        800: Color(0xff1a224c),
        900: Color(0xff0d1126)
      }),
      canvasColor: Color(0xff091945),

      */
