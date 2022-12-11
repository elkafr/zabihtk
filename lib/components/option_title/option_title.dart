import 'package:flutter/material.dart';
import 'package:zabihtk/utils/app_colors.dart';
class OptionTitle extends StatelessWidget {
  final String title;
  final String value;

  const OptionTitle({Key key, this.title, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(
        style: TextStyle(
            height: 1.3,
            fontWeight: FontWeight.w700,
            color: cAccentColor,
            fontSize: 13,
            fontFamily: 'HelveticaNeueW23forSKY'),
        children: <TextSpan>[
          TextSpan(text: title),
          TextSpan(text: ' : '),
          TextSpan(
            text: value,
            style: TextStyle(
                height: 1.3,
                color: cBlack,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'HelveticaNeueW23forSKY'),
          ),
        ],
      ),
    );
  }
}