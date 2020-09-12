import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran_app',
      theme: _themeNotifier.darkmode ? _themeNotifier.dark : _themeNotifier.light,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        //'/settings': (context) => Settings(),
        //'/about': (context) => About(),
      },
    );
  }
}