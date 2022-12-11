import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zabihtk/app_repo/progress_indicator_state.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:provider/provider.dart';


class ProgressIndicatorComponent extends StatelessWidget {
  final bool isLoading;
  const ProgressIndicatorComponent({Key key, this.isLoading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressIndicatorState>(
      builder: (context, progressIndicatorState, child) {
        return Center(
            child: progressIndicatorState.isLoading
                ? SpinKitCircle(
                    color: cPrimaryColor,
                  )
                : Container());
      },
    );
  }
}
