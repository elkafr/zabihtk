
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zabihtk/components/buttons/custom_button.dart';
import 'dart:math' as math;

import 'package:zabihtk/utils/app_colors.dart';



class NotRegistered extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height =  MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Transform.rotate(
          angle: 180 * math.pi / 180,
          child: Icon(
            FontAwesomeIcons.signInAlt,
            color: cPrimaryColor,
            size: height * 0.12,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: height*0.02),
          child: Text(
            'يرجي تسجيل الدخول أولاً',
            style: TextStyle(
                color: cBlack, fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: height*0.02,
              left: width * 0.15,
              right: width * 0.15),
          height: 60,
          child: CustomButton(
              btnLbl: 'تسجيل الدخول',
              onPressedFunction: () async {
                Navigator.pushNamed(context, '/login_screen');
              }),
        ),
      ],
    ));
  }
}
