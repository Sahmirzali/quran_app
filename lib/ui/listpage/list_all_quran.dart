import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:quran_app/data/models/allsurah.dart';
import 'package:quran_app/data/models/surah_info.dart';
import 'package:quran_app/data/services.dart';
import 'package:quran_app/data/utils/config_helper.dart';
import 'package:quran_app/ui/widget/cardsurah.dart';

import '../detail_surah.dart';

class ListAllSurah extends StatefulWidget {
  ListAllSurah({Key key}) : super(key: key);

  @override
  _ListAllSurahState createState() => _ListAllSurahState();
}

class _ListAllSurahState extends State<ListAllSurah> {
  List<SurahInfo> allSurahInfos = new List();
  List<SurahInfo> serachResultList = new List();
  List<SurahInfo> viewSurahList = new List();
  ServiceData serviceData;
  String sonsureAdi;
  String sonsureNo;
  String sonAyet;
  getSurahInfos() async {
    allSurahInfos = await serviceData.loadInfo();
    viewSurahList = allSurahInfos;
    for (var data in viewSurahList) {
      data.endNumber = await ConfigHelper().getShared(data.index);
    }
    sonsureAdi = await ConfigHelper().getSharedString("sonSureAdi");

    if (sonsureAdi != null) {
      sonsureNo = await ConfigHelper().getShared("sonSureNo");
      sonAyet = await ConfigHelper().getShared(sonsureNo);

      var s = sonAyet;
    }

    setState(() {});
  }

  int number = 0;
  @override
  void initState() {
    super.initState();

    serviceData = ServiceData();
    getSurahInfos();
  }

  final String assetName = 'images/lastread.svg';
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenPadding = MediaQuery.of(context).padding;
    var textScale = MediaQuery.of(context).textScaleFactor;
    int number = 0;

    return allSurahInfos.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 0,
                ),
                /*Container(
                  margin:
                      EdgeInsets.only(top: 15, left: 22, right: 22, bottom: 5),
                  child: TextField(
                    autofocus: false,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintText: 'Search ',
                      alignLabelWithHint: false,

                      // filled: true
                    ),
                    onChanged: (text) {
                      if (text == '') {
                        viewSurahList = allSurahInfos;
                      } else {
                        serachResultList.clear();
                        allSurahInfos.forEach((e) {
                          if (e.latin
                              .toLowerCase()
                              .contains(text.toLowerCase()))
                            serachResultList.add(e);
                        });

                        setState(() {
                          viewSurahList = serachResultList;
                        });
                      }
                    },
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: SizedBox(
                    //height: 139.4,
                    //width: double.infinity,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            child: Image.asset(
                              'images/sonoxunan.jpg',
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height / 15.8,
                            left: MediaQuery.of(context).size.width / 17,
                            child: Text(
                              sonsureAdi == null ? " " : "$sonsureAdi",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 19 * textScale,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height / 29.5,
                            left: MediaQuery.of(context).size.width / 17,
                            child: Text(
                              sonsureAdi == null ? "" : "Ayə no:  $sonsureNo",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15 * textScale,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                

                /* Container(
                  child: Text(sonsureAdi == null
                      ? " kaydetmediniz"
                      : "Son Okunan : $sonsureAdi ayah:  $sonsureNo"),
                ),
                SizedBox(
                  height: 10,
                ), */
                GestureDetector(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      autofocus: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: _textController.text.length >= 0
                            ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    _textController.clear();
                                    viewSurahList = allSurahInfos;
                                  });
                                })
                            : new Container(
                                height: 0.0,
                              ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 25.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        hintText: "Surələr üzrə axtar",
                        alignLabelWithHint: false,
                        filled: false,
                      ),
                      onChanged: (text) {
                        if (text.isEmpty) {
                          viewSurahList = allSurahInfos;
                        } else {
                          serachResultList.clear();
                          allSurahInfos.forEach((e) {
                            if (e.latin
                                .toLowerCase()
                                .contains(text.toLowerCase()))
                              serachResultList.add(e);
                          });

                          setState(() {
                            viewSurahList = serachResultList;
                          });
                        }
                      },
                      controller: _textController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
                ListView(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: viewSurahList.map((data) {
                    return CardSurah(
                      title: data.latin,
                      subtitle: data.type,
                      surah: data.index.toString(),
                      ayah: data.ayahCount.toString(),
                      //ayah: number.toString(),
                      arabic: data.arabic,
                      endnumber:
                          data.endNumber == null ? "" : data.endNumber,
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailSurah(
                                      detail: data.latin,
                                      indexx: data.index,
                                      information: data.type,
                                      type: data.type,
                                      ayahcount: data.ayahCount,
                                    )));
                        await getSurahInfos();
                      },
                    );
                    
                    
                  }).toList(),
                  
                ),
                SizedBox(
                  height: 10,
                ),
               
              ],
            ),
          )
        : PKCardListSkeleton(
            isCircularImage: true,
            isBottomLinesActive: true,
            length: 10,
          );
  }
}



/*Container(
        width: 350,
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              fit: BoxFit.cover,
              image: AssetImage('images/lastread.png'),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Column(
                children: <Widget>[
                  Text(
                    "Jerusalem",
                    style: TextStyle(
                        //fontFamily: 'AirbnbCerealBold',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "1,243 Place",
                    style: TextStyle(
                        //fontFamily: 'AirbnbCerealBook',
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), */
                /*Container(
                  
                  width: 300,
                  height: 220,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    
                    image: DecorationImage(
                      
                        image: AssetImage('images/lastread.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Jerusalem",
                        style: TextStyle(
                            
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text("1,243 Place", style: TextStyle(
                          
                          fontSize: 14,
                          color: Colors.white),
                      ),
                    ],
                  ),
                ), */