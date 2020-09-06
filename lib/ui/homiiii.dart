import 'package:flutter/material.dart';
import 'package:quran_app/data/utils/data.dart';
import 'package:quran_app/ui/search_ayahs.dart';

import 'listpage/list_all_quran.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin 
    {
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
    super.build(context);
    return NestedScrollView(
      
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            elevation: 10,
            forceElevated: true,
           //  titleSpacing: ,
           toolbarHeight: 55,
             //flexibleSpace: FlexibleSpaceBar(titlePadding: ,),
            shadowColor: Colors.black,
            backgroundColor: Colors.deepPurple[400],
            //centerTitle: true,
            title: Text("Qurani kərim",style: TextStyle(color: Colors.white),),
            pinned: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.album),
                onPressed: () {
                  
                },
              )
            ],
          )
        ];
      },
      body: ListAllSurah(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
