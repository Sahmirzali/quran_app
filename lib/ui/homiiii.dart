import 'package:flutter/material.dart';
import 'package:quran_app/data/utils/data.dart';
import 'package:quran_app/ui/search_ayahs.dart';

import 'listpage/list_all_quran.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    //with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin 
    {
  //TabController _tabController;

  @override
  void initState() {
    super.initState();
    //_tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // super.build(context);
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.deepPurple[800],
            centerTitle: true,
            title: Text("TexT"),
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
          )
        ];
      },
      body: ListAllSurah(),
    );
  }

  //@override
  //bool get wantKeepAlive => true;
}
