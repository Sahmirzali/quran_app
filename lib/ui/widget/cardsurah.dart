import 'package:flutter/material.dart';
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

  //String endnumber = "0";
  final String title, subtitle, surah, ayah, arabic, endnumber;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var color = 0xff1D1729;
    var color2 = 0xffA44AFF;
    var colorarabic = 0xffA44AFF;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 3.0,
        ),
        child: Card(
          //color: Colors.white,
          elevation: 0.0,
          child: Container(
            padding: EdgeInsets.only(
              left: 12,
              right: 12,
            ),
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
                            //color: Colors.white,
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
                                _customTextWidget,
                                //example
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
                                //color: Color(color),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        arabic,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Color(colorarabic),
                          fontSize: 33,
                          fontFamily: 'Uthman',
                          height: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Divider(
                    //color: Colors.grey[400],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _customTextWidget => Text(
        surah,
        style: TextStyle(
          fontSize: 15,
          // color: Colors.black,
        ),
      );
}