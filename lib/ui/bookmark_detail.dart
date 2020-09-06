import 'package:flutter/material.dart';
import 'package:quran_app/data/models/allsurah.dart';
import 'package:quran_app/data/services.dart';

class BookmarkDetail extends StatefulWidget {
  final detail;
  final information;
  final  datam;

  final String indexx;

  BookmarkDetail({Key key, this.detail, this.information, this.indexx, this.datam, int id})
      : super(key: key);

  @override
  _BookmarkDetailState createState() => _BookmarkDetailState();
}

class _BookmarkDetailState extends State<BookmarkDetail> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.detail),
        elevation: 0.0,
      ),
      body: Card(
        child: ListTile(
          title: Column(
            children: [
              Text(widget.datam),
              Text('datam1'),
            ],
          ),
          subtitle: Text('datam2'),
          trailing: Text('datam3'),
        ),
      ),
    );
  }
}
