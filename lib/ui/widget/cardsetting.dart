import 'package:flutter/material.dart';

class CardSetting extends StatelessWidget {
  const CardSetting({
    Key key,
    @required this.title,
    @required this.leading,
  }) : super(key: key);

  final String title;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    var textScale = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      child: Card(
        elevation: 0,
        child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15.3 * textScale,
                fontWeight: FontWeight.w400,
                //color: Colors.deepPurple[900],
              ),
            ),
            trailing: leading),
      ),
    );
  }
}
