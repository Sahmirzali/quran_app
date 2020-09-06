import 'package:flutter/material.dart';
import 'package:quran_app/data/utils/style.dart';
import 'package:quran_app/ui/icon/surah_figure_icons.dart';

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
    var color = 0xff1D1729;
    var color2 = 0xff7723E2;
    var colorarabic = 0xff6E0BEC;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 0),
        child: Card(
          color: Colors.white,
          elevation: 0.0,
          child: Container(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 65.0,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Icon(
                                  SurahFigure.fiqur,
                                  color: Color(color2),
                                  //color: Colors.blue,
                                  size: 47.0,
                                ),
                                Text(
                                  surah,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$title surəsi",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.7,
                                fontWeight: FontWeight.w500,
                                color: Color(color),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Oxuduğunuz son ayə: $endnumber",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),

                    /*SizedBox(
                      width: 14,
                    ),*/
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        arabic,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Color(colorarabic),
                          fontSize: 30,
                          fontFamily: 'Uthman',
                          height: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
/*
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
                  ),*/
