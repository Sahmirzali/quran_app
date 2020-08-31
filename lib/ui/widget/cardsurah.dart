import 'package:flutter/material.dart';
import 'package:quran_app/data/utils/style.dart';

class CardSurah extends StatelessWidget {
  CardSurah(
      {this.title,
      this.subtitle,
      this.surah,
      this.ayah,
      this.arabic,
      this.onTap,
      this.endnumber});

  String endnumber = "0";
  final String title, subtitle, surah, ayah, arabic;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
          child: Padding(
      
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          
            elevation: 0.0,
            child: Container(
              

              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        height: 150.0,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.stars,
                                color: Colors.blue,
                                size: 100.0,
                              ),
                              Text(
                                surah,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(title,style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  /*ListTile(
                    onTap: onTap,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        title,
                        style: AppStyle.title,
                      ),
                    ),
                    subtitle: Text(subtitle, style: AppStyle.subtitle),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),*/
                  AppStyle.spaceH5,
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('Surat Ke', style: AppStyle.end2subtitle),
                            AppStyle.spaceH5,
                            Text(
                              surah,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('Ayat', style: AppStyle.end2subtitle),
                            AppStyle.spaceH5,
                            Text(
                              ayah,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('Arabic', style: AppStyle.end2subtitle),
                            AppStyle.spaceH5,
                            Text(
                              arabic,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('endNumber', style: AppStyle.end2subtitle),
                            AppStyle.spaceH5,
                            Text(
                              endnumber,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
