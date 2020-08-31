import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_app/ui/home_page.dart';

import 'data/uistate.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UiState()),
          //ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home_Page(),
        //'/settings': (context) => Settings(),
        //'/about': (context) => About(),
      },
    );
  }
}
