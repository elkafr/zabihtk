import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zabihtk/utils/app_colors.dart';


class PageContainer extends StatelessWidget {
  final Widget child;
  const PageContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Platform.isIOS ? cWhite : cPrimaryColor,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus( FocusNode());
            },
            child: child,
          ),
        ));
  }
}
