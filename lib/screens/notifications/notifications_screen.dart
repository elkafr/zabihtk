import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zabihtk/components/safe_area/page_container.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/screens/notifications/components/notification_item.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/services/access_api.dart';
import 'package:zabihtk/models/notification_message.dart';
import 'package:zabihtk/components/no_data/no_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  double _height, _width;


  bool _initialRun = true;
  AppState _appState;
  Services _services = Services();
  Future<List<NotificationMsg>> _orderList;


  Future<List<NotificationMsg>> _getOrderList() async {
    Map<String, dynamic> results = await _services.get(
        '${Utils.NOTIFICATION_URL}user_id=57&page=1');
    List orderList = List<NotificationMsg>();
    if (results['response'] == '1') {
      Iterable iterable = results['result'];
      orderList = iterable.map((model) => NotificationMsg.fromJson(model)).toList();
    } else {
      print('error');
    }
    return orderList;
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _orderList = _getOrderList();
      _initialRun = false;
    }
  }


  Widget _buildBodyItem() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<NotificationMsg>>(
      future: _orderList,
      builder: (context, snapshot) {
        print(_orderList);
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return Text('data');


          } else {
            return NoData(
              message: AppLocalizations.of(context).noResults,
            );
          }
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }

        return Center(
            child: SpinKitThreeBounce(
              color: cPrimaryColor,
              size: 40,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    final appBar = AppBar(
      centerTitle: true,
      title: Text(AppLocalizations.of(context).notifications,
          style: Theme.of(context).textTheme.display1),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
          child: Image.asset(
            'assets/images/notification.png',
            color: cWhite,
            height: 25,
            width: 25,
          ),
        )
      ],
    );

    _height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return PageContainer(
      child: Scaffold(
        appBar: appBar,
        body: _buildBodyItem(),
      ),
    );
  }
}
