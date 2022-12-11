import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zabihtk/components/safe_area/page_container.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/screens/notifications/components/notification_item.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/app_repo/notification_provider.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/services/access_api.dart';
import 'package:zabihtk/models/notification_message.dart';
import 'package:zabihtk/components/no_data/no_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:zabihtk/models/notification_message.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/components/not_registered/not_registered.dart';
import 'package:zabihtk/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>  with TickerProviderStateMixin{
  double _height = 0 , _width = 0;
  AnimationController _animationController;
  AppState _appState;
  Services _services = Services();




  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

Widget _buildBodyItem(){
  return ListView(
    children: <Widget>[
      SizedBox(
        height: 10,
      ),
      Container(
        height: _height - 150,
        width: _width,
        child: FutureBuilder<List<NotificationMsg>>(
                  future:  Provider.of<NotificationProvider>(context,
                          listen: true)
                      .getMessageList() ,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: SpinKitFadingCircle(color: cPrimaryColor),
                        );
                      case ConnectionState.active:
                        return Text('');
                      case ConnectionState.waiting:
                        return Center(
                          child: SpinKitFadingCircle(color: cPrimaryColor),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Center(child: Text("${snapshot.error}"));
                        } else {
                          if (snapshot.data.length > 0) {
                     return     ListView.builder(
            itemCount: snapshot.data.length,
             itemBuilder: (BuildContext context, int index) {
               var count = snapshot.data.length;
                      var animation = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      _animationController.forward();
               return Dismissible(
                              // Each Dismissible must contain a Key. Keys allow Flutter to
                              // uniquely identify widgets.
                              key: Key(snapshot.data[index].messageId),
                              // Provide a function that tells the app
                              // what to do after an item has been swiped away.
                              onDismissed: (direction) async {
                                // Remove the item from the data source.
                             await   _services.get(Utils.DELETE_NOTIFICATION_URL +
         'user_id=${_appState.currentUser.userId}&notify_id=${snapshot.data[index].messageId}');
                      setState(() {
                                  
                                  snapshot.data.removeAt(index);
                                });

                               
                              },
                              // Show a red background as the item is swiped away.
                              background: Container(color: Colors.red),
                              child: Container(
              height: _height *0.110,
              child: NotificationItem(
                notificationMsg: snapshot.data[index],
              )));
             }
          );
                          } else {
                            return NoData(message:AppLocalizations.of(context).noResults);
                          }
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: cPrimaryColor),
                    );
                  })
       
      )
    ],
  );
}

@override
  Widget build(BuildContext context) {
    _appState = Provider.of<AppState>(context);
    final appBar = AppBar(
      backgroundColor: cPrimaryColor,
      centerTitle: true,
      title: Text(AppLocalizations.of(context).notifications,
          style: Theme.of(context).textTheme.display1),
    );
  //  print(_appState.currentUser.userId);
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return PageContainer(
      child: Scaffold(
        appBar: appBar,
        body: Stack(
          children: <Widget>[
            Consumer<AppState>(builder: (context, appState, child) {
              return appState.currentUser != null
                  ? _buildBodyItem()
                  : NotRegistered();
            }),
            Center(
              child: ProgressIndicatorComponent(),
            )
          ],
        ),
      ),
    );
  }
}