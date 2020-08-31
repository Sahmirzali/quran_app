import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quran_app/ui/bookmark.dart';
import 'package:quran_app/ui/search_ayahs.dart';
import 'package:quran_app/ui/settings.dart';

import 'homiiii.dart';

class Home_Page extends StatefulWidget {
  Home_Page({Key key}) : super(key: key);

  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  PageController _pageController = PageController();
  List<Widget> _screen = [
    Home(),
    Search_Ayahs(),
    Bookmark(),
    Settings(),
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
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
              ),
            ),
          ), 
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
            ),
            title: Text(
              'Search',
              style: TextStyle(
                color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
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
              color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
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

/*import 'package:flutter/material.dart';
import 'package:quran_app/data/utils/data.dart';
import 'package:quran_app/ui/search_ayahs.dart';

import 'listpage/list_all_quran.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.deepPurple[800],
              centerTitle: true,
              title: Text("Text"),
              pinned: false,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => null));
                  },
                )
              ],
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.blue,
                indicatorWeight: 4,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.4),
                labelPadding: EdgeInsets.symmetric(horizontal: 30),
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      'Text1',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Text2',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            All_Surah(),
            Search_Ayahs(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark),title: Text('Bookmark')),
          BottomNavigationBarItem(icon: Icon(Icons.settings),title: Text('Settings')),
        ],
      ),
    );
  }
} */

/*import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  Home_Page({Key key}) : super(key: key);

  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: null,
    );
  }
} */
