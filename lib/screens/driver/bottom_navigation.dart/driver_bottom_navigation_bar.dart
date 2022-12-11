import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:zabihtk/app_data/shared_preferences_helper.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/app_repo/driver_navigation_state.dart';
import 'package:zabihtk/components/connectivity/network_indicator.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/models/user.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:provider/provider.dart';


class DriverBottomNavigation extends StatefulWidget {
  @override
  _DriverBottomNavigationState createState() => _DriverBottomNavigationState();
}

class _DriverBottomNavigationState extends State<DriverBottomNavigation> {
  bool _initialRun = true;
  AppState _appState;
  DriverNavigationState _driverNavigationState;




  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();

  void _iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void _firebaseCloudMessagingListeners() {
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    _flutterLocalNotificationsPlugin.initialize(platform);

    if (Platform.isIOS) _iOSPermission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        _showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');

        Navigator.pushNamed(context, '/notification_screen');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');

        Navigator.pushNamed(context, '/notification_screen');
      },
    );
  }

  _showNotification(Map<String, dynamic> message) async {
    var android = new AndroidNotificationDetails(
      'channel id',
      "CHANNLE NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await _flutterLocalNotificationsPlugin.show(
        0,
        message['notification']['title'],
        message['notification']['body'],
        platform);
  }



  Future<Null> _checkIsLogin() async {
    var userData = await SharedPreferencesHelper.read("user");
    if (userData != null) {
      _appState.setCurrentUser(User.fromJson(userData));
      _firebaseCloudMessagingListeners();
    }
  }


 

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) { 
      _appState = Provider.of<AppState>(context);
      _checkIsLogin();
        _initialRun = false;
      
    }
  }

  @override
  Widget build(BuildContext context) {
    _driverNavigationState = Provider.of<DriverNavigationState>(context);
    _appState = Provider.of<AppState>(context);

    return NetworkIndicator(
        child: Scaffold(
      body: _driverNavigationState.selectedContent,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/requests.png',
               color: Color(0xFFC7C7C7),
            ),
             activeIcon: Image.asset(
              'assets/images/requests.png',
              color: cAccentColor,
            ),
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  AppLocalizations.of(context).orders,
                  style: TextStyle(fontSize: 14.0),
                )),
          ),


          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/notification.png',
              color: Color(0xFFC7C7C7),
            ),
            activeIcon: Image.asset(
              'assets/images/notification.png',
              color: cAccentColor,
            ),
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  AppLocalizations.of(context).notify,
                  style: TextStyle(fontSize: 14.0),
                )),
          ),

            BottomNavigationBarItem(
           icon: Image.asset(
              'assets/images/profile.png',
               color: Color(0xFFC7C7C7),
            ),
            activeIcon: Image.asset(
              'assets/images/profile.png',
              color: cAccentColor,
            ),
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                 AppLocalizations.of(context).account,
                  style: TextStyle(fontSize: 14.0),
                )),
          )
        ],
        currentIndex: _driverNavigationState.drivernavigationIndex,
        selectedItemColor: cAccentColor,
        unselectedItemColor: Color(0xFFC4C4C4),
        onTap: (int index) {
          if((index == 1 || index  == 2) && _appState.currentUser == null){
             Navigator.pushNamed(context, '/driver_login_screen');
          }else{
            _driverNavigationState.upadatedriverNavigationIndex(index);
          }
        
        },
        elevation: 5,
        backgroundColor: cWhite,
        type: BottomNavigationBarType.fixed,
      ),
    ));






  }
}
