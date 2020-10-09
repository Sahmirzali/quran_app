import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/data/themes.dart';

import 'package:quran_app/ui/home_page.dart';

import 'data/uistate.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UiState()),
          ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    deleteData();
    
  }

  Directory klasor;
  String sd;
  deleteData() async {
    klasor = await getExternalStorageDirectory();
    sd = klasor.parent.parent.parent.parent.path;
    if (Directory(join(sd, "QuranMeal")).existsSync() ||
        Directory(join(sd, "AppName")).existsSync()) {
      Directory(join(sd, "QuranMeal")).deleteSync(recursive: true);
      Directory(join(sd, "AppName")).deleteSync(recursive: true);
      
    }
    if (Directory(join(sd, "QuranData")).existsSync() ) {
      Directory(join(sd, "QuranData")).deleteSync(recursive: true);
    }
    if (Directory(join(sd, "MealData")).existsSync()) {
      Directory(join(sd, "MealData")).deleteSync(recursive: true);
    }
    if (Directory(join(sd, "MealName")).existsSync()) {
      Directory(join(sd, "MealName")).deleteSync(recursive: true);
    }
    
  }

  

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran_app',
      theme:
          _themeNotifier.darkmode ? _themeNotifier.dark : _themeNotifier.light,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        //'/settings': (context) => Settings(),
        //'/about': (context) => About(),
      },
    );
  }
}
