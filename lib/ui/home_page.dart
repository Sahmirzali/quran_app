import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quran_app/ui/about.dart';
import 'package:quran_app/ui/bookmark.dart';
import 'package:quran_app/ui/search_ayahs.dart';
import 'package:quran_app/ui/settings.dart';

import 'list_all_quran.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screen = [
    ListAllSurah(),
    Search_Ayahs(),
    Bookmark(),
    About(),
  ];

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    super.initState();
    _getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Colors.deepPurple[400] : Colors.grey,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: _selectedIndex == 0 ? Colors.deepPurple[400] : Colors.grey,
              ),
            ),
          ), 
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _selectedIndex == 1 ? Colors.deepPurple[400] : Colors.grey,
            ),
            title: Text(
              'Search',
              style: TextStyle(
                color: _selectedIndex == 1 ? Colors.deepPurple[400] : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              color: _selectedIndex == 2 ? Colors.deepPurple[400] : Colors.grey,
            ),
            title: Text(
              'Bookmark',
              style: TextStyle(
                color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _selectedIndex == 3 ? Colors.deepPurple[400] : Colors.grey,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getPermission() async {
    var permissionRequestResult = await Permission.storage.request();
    if (permissionRequestResult == PermissionStatus.granted) {
      setState(() {});
    } else {
      exit(0);
    }
  }
}

