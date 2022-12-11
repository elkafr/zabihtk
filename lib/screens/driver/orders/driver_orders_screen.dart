import 'package:flutter/material.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/app_repo/tab_state.dart';

import 'package:zabihtk/components/connectivity/network_indicator.dart';
import 'package:zabihtk/components/not_registered/not_registered.dart';
import 'package:zabihtk/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:zabihtk/components/safe_area/page_container.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/screens/driver/orders/components/driver_current_orders.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:zabihtk/screens/driver/orders/components/driver_previous_orders.dart';

class DriverOrdersScreen extends StatefulWidget {
  @override
  _DriverOrdersScreenState createState() => _DriverOrdersScreenState();
}

class _DriverOrdersScreenState extends State<DriverOrdersScreen> {
  double _height, _width;

 

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
                     DriverCurrentOrders(),
                     DriverPreviousOrders()
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
      title: Text(AppLocalizations.of(context).orders,
          style: Theme.of(context).textTheme.display1),
    );
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    final tabState = Provider.of<TabState>(context);
   

    return NetworkIndicator(
        child: PageContainer(
      child: DefaultTabController(
          initialIndex: tabState.initialIndex,
          length: 2,
          child: Scaffold(
              appBar: appBar,
              body: Stack(
                children: <Widget>[
                  _buildBodyItem(),
                  Positioned(
                    top: 0,
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
                            Text(AppLocalizations.of(context).current),
                            Text(AppLocalizations.of(context).previous),
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
