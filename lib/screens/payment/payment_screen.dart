import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/app_repo/location_state.dart';
import 'package:zabihtk/app_repo/payment_state.dart';
import 'package:zabihtk/app_repo/progress_indicator_state.dart';
import 'package:zabihtk/components/buttons/custom_button.dart';
import 'package:zabihtk/components/connectivity/network_indicator.dart';
import 'package:zabihtk/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:zabihtk/components/drop_down_list_selector/default_shape_drop_down.dart';
import 'package:zabihtk/components/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:zabihtk/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:zabihtk/components/response_handling/response_handling.dart';
import 'package:zabihtk/components/safe_area/page_container.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/models/bank.dart';
import 'package:zabihtk/services/access_api.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/utils/utils.dart';
import 'package:zabihtk/screens/payment/components/cash.dart';
import 'package:zabihtk/screens/payment/components/visa.dart';
import 'package:zabihtk/screens/payment/components/transfer.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;
import 'package:validators/validators.dart';


import 'package:flutter/material.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/app_repo/pay_state.dart';

import 'package:zabihtk/components/connectivity/network_indicator.dart';
import 'package:zabihtk/components/not_registered/not_registered.dart';
import 'package:zabihtk/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:zabihtk/components/safe_area/page_container.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/screens/orders/components/current_orders.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:zabihtk/screens/orders/components/previous_orders.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {


  double _height, _width;

PayState _payState;

  Widget _buildBodyItem() {
    return Consumer<AppState>(builder: (context, appState, child) {
      return appState.currentUser != null
          ? ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            height: _height - 170,
            child: TabBarView(
              children: [
                Cash(),
                Transfer(),
                Visa(),
              ],
            ),
          )
        ],
      )
          : NotRegistered();
    });
  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      backgroundColor: cPrimaryColor,
      centerTitle: true,
      title: Text(AppLocalizations.of(context).confirmOrder,
          style: Theme.of(context).textTheme.display1),
    );
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    final payState = Provider.of<PayState>(context);


    return NetworkIndicator(
        child: PageContainer(
          child: DefaultTabController(
              initialIndex: payState.initialIndex,
              length: 3,
              child: Scaffold(
                  appBar: appBar,
                  body: Stack(
                    children: <Widget>[

                      _buildBodyItem(),
                      Positioned(
                        top: 15,
                        child: Container(
                            width: _width,
                            height: 40,
                            color: cWhite,

                            child: TabBar(

                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  fontFamily: 'HelveticaNeueW23forSKY'),
                              unselectedLabelColor: cBlack,
                              unselectedLabelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'HelveticaNeueW23forSKY'),
                              labelColor: cAccentColor,
                              indicatorColor: cAccentColor,

                              tabs: [

                                Container(
                                  width: _width * 0.24,
                                  height: 40,
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffC7C7C7)),
                                    borderRadius: BorderRadius.circular(20),
                                    color:cWhite,
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(

                                        margin: EdgeInsets.only(top: 2),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[


                                            Text(
                                              AppLocalizations.of(context).cash,
                                              style: TextStyle(
                                                  color: cPrimaryColor, fontSize: 16),
                                            ),

                                          ],
                                        ),

                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  width: _width * 0.24,
                                  height: 40,
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffC7C7C7)),
                                    borderRadius: BorderRadius.circular(20),
                                    color:cWhite,
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(

                                        margin: EdgeInsets.only(top: 2),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[


                                            Text(
                                              AppLocalizations.of(context).transfer,
                                              style: TextStyle(
                                                  color: cPrimaryColor, fontSize: 16),
                                            ),

                                          ],
                                        ),

                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  width: _width * 0.24,
                                  height: 40,
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffC7C7C7)),
                                    borderRadius: BorderRadius.circular(20),
                                    color:cWhite,
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(

                                        margin: EdgeInsets.only(top: 2),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[


                                            Text(
                                              AppLocalizations.of(context).visa,
                                              style: TextStyle(
                                                  color: cPrimaryColor, fontSize: 16),
                                            ),

                                          ],
                                        ),

                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            )),
                      )

                      ,
                      Center(
                        child: ProgressIndicatorComponent(),
                      )
                    ],
                  ))),
        ));
  }


}
