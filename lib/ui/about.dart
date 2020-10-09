import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/data/themes.dart';
import 'package:quran_app/data/uistate.dart';
import 'package:quran_app/ui/widget/cardsetting.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var thememode = Provider.of<ThemeNotifier>(context);
    var titleColor = 0xff803BE2; 
    var titleColor2 = 0xffA261FF;
    var textScale = MediaQuery.of(context).textScaleFactor;
    var ui = Provider.of<UiState>(context);
    var dark = Provider.of<ThemeNotifier>(context);

    Future<void> shareMeal() async {
      await FlutterShare.share(
          title: 'Qurani kərim və məalı',
          text: 'Qurani kərim və məalı',
          linkUrl:
              'https://play.google.com/store/apps/details?id=com.meal.quran_app',
          chooserTitle: 'Qurani kərim və məalı');
    }

    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 28, left: 27, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Tətbiq haqqında",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20 * textScale,
                        fontWeight: FontWeight.w600,
                        color: thememode.darkmode
                            ? Colors.white
                            : Color(titleColor),
                        //color: Colors.deepPurple[900],
                      ),
                    ),
                  ],
                ),
              ),
              CardSetting(
                title: 'Qaranlıq rejimi aktiv edin',
                leading: Switch(
                  value: dark.darkmode,
                  onChanged: (val) => dark.switchTheme(),
                ),
              ),
              CardSetting(
                title: 'Ərəb dilini göstər',
                leading: Switch(
                  value: ui.arabic,
                  onChanged: (newValue) => ui.arabic = newValue,
                ),
              ),
              CardSetting(
                title: 'Azərbaycan dilini göstər',
                leading: Switch(
                  value: ui.terjemahan,
                  onChanged: (newValue) => ui.terjemahan = newValue,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Divider(
                height: 1,
                indent: 25,
                endIndent: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, top: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.82,
                  child: RaisedButton(
                    onPressed: () {
                      shareMeal();
                      //Share.share('Qurani kərim və məalı \nhttps://play.google.com/store/apps/details?id=com.meal.quran_app',subject: 'tətbiq kateoqiryasi');
                    },
                    color: Color(titleColor2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50,right: 60),
                          child: Text(
                            'Tətbiqi paylaş',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16 * textScale,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
             
               Padding(
                padding: const EdgeInsets.only(right: 12, top: 11),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.82,
                  child: RaisedButton(
                    onPressed: () {
                      FlutterOpenWhatsapp.sendSingleMessage("994507683081", "");
                    },
                    color: Color(titleColor2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Ionicons.logo_whatsapp,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80,right: 90),
                          child: Text(
                            'Əlaqə',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16 * textScale,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Azərbaycan dilinə tərcümə edən:",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14 * textScale,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          //color: Colors.deepPurple[900],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Ələddin Sultanov",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.5 * textScale,
                          fontWeight: FontWeight.w500,
                          //color: Colors.deepPurple[900],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Proqram tərtibi:",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.7 * textScale,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          //color: Colors.deepPurple[900],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Hüseynov Şahmirzəli",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.5 * textScale,
                          fontWeight: FontWeight.w500,
                          //color: Colors.deepPurple[900],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Mütəllimov Marif",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.5 * textScale,
                          fontWeight: FontWeight.w500,
                          //color: Colors.deepPurple[900],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 23, right: 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bismilləhir-Rahmənir-Rahim",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.5 * textScale,
                                fontWeight: FontWeight.w500,
                                //color: Colors.deepPurple[900],
                              ),
                            ),
                            /* SizedBox(
                        height: 10,
                      ),*/
                            Container(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                """İstifadə etdiyiniz bu tətbiqə "Qurani-Kərim və məalı" adını verdiyimiz üçün onun adında "tərcumə" deyil, ”məal” Ifadəsinə yer verməyimizin məqsədinə də aydınlıq gətirmək istəyirik. Dilimizdə “tərcümə” sözü “bir dildən başqa dilə çevirmək” mənasına gəldiyi halda, “məal” sözü isə “bir yazı və ya söz ilə anladılmaq istənilən fikir” mənasını verir. Bu sözlərin arxaizminə nəzər saldığımız zaman görürük ki, ərəb mənşəli “tərcümə” sözünün termin mənası lüğət kitablarında “bir kəlmənin mənasının başqa dildə həmin kəlmənin tam əvəzi olan sözlərlə ifadə etmək “ şəklində izah edilir. İslam alimləri Allah kəlamı olan Qurani-Kərim sözlərinin digər dillərə tam şəkildə və eynisi ilə tərcümə edilməsinin imkansız olduğunu qeyd etmişlər. Çünki Qurani-Kərimin möcüzəvi bir kitab olmasının əsasında onun ecazkarlığı dayanır. Heç bir dildə onun ecazkarlığını əvəz edəcək ifadələr tapmaq mümkün deyildir. Digər tərəfdən ərəb dili söz ehtiyatı baxımından çox zəngin dildir və Quranda bir çox mənaları ehtiva edən vəciz ifadələr yer alır. Bu ifadələrin ehtiva etdiyi dərin mənaları başqa dillərdə ifadə etmək isə olduqca çətindir. Buna görə də bu kimi fəaliyyətlərin “məal”, “təvil” və ya “təfsir” kimi fərqli ifadələrlə adlandırılması daha münasib görülmüşdür.
Məal sözü ərəb dilindəki “əvl” felinin məsdər formasıdır və termin etibarilə sözün mənasını tam olaraq deyil, ona yaxın sözlərlə ifadə etməyə məal deyilmişdir. Beləcə, məal ifadəsi ilə Qurani-Kərimi eynisi ilə nöqsansız bir şəkildə tərcümə etməyin mümkün olmadığını ifadə etmiş oluruq. Digər tərəfdən məal sözü Qurani-Kərim ayələrinin fərqli ifadələrlə izah və şərh edilməsi mənasını daşıyan “təvil” sözü ilə eyni kökdən gəlir və qismi şərhləri ehtiva edir. Biz də zəruri gördüyümüz hallarda müəyyən ayələrə izahlar vermişik və bu da “məal” kəlməsinin ehtiva etdiyi məna ilə uyğunluq daşıyır.""",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.5 * textScale,
                                  fontWeight: FontWeight.w400,
                                  //color: Colors.deepPurple[900],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
