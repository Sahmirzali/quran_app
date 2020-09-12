import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/data/themes.dart';
import 'package:quran_app/data/uistate.dart';
import 'package:quran_app/ui/widget/cardsetting.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var textScale = MediaQuery.of(context).textScaleFactor;
    var ui = Provider.of<UiState>(context);
    var dark = Provider.of<ThemeNotifier>(context);

    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(
          height: 42,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  "Tənzimləmələr",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20 * textScale,
                    fontWeight: FontWeight.w600,
                    //color: Colors.deepPurple[900],
                  ),
                ),
              ],
            ),
         
          ],
        ),
        SizedBox(height: 15,),
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
        CardSlider(
          title: 'Ərəbcə mətn ölçüsü',
          slider: Slider(
            min: 1,
            max: 80,
            value: ui.fontSize,
            onChanged: (newValue) => ui.fontSize = newValue,
          ),
          trailing: ui.fontSize.toInt().toString(),
        ),
        CardSlider(
          title: 'Azərbaycanca mətn ölçüsü',
          slider: Slider(
            min: 1,
            max: 35,
            value: ui.fontSizetext,
            onChanged: (newValue) => ui.fontSizetext = newValue,
          ),
          trailing: ui.fontSizetext.toInt().toString(),
        ),
      ],
    ));
  }
}

class CardSlider extends StatelessWidget {
  const CardSlider({
    Key key,
    @required this.title,
    @required this.slider,
    @required this.trailing,
  }) : super(key: key);

  final String title;
  final Widget slider;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    var textScale = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Card(
        elevation: 0,
        child: ListTile(
          contentPadding: EdgeInsets.only(top: 10, right: 30, left: 15),
          title: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15.3 * textScale,
                    fontWeight: FontWeight.w400,
                    //color: Colors.deepPurple[900],
                  ),
                ),
          subtitle: slider,
          trailing: Text(trailing),
        ),
      ),
    );
  }
}
