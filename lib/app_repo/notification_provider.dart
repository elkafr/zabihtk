import 'package:zabihtk/utils/utils.dart';
import 'package:zabihtk/models/notification_message.dart';
import 'package:zabihtk/models/user.dart';
import 'package:zabihtk/services/access_api.dart';
import 'package:flutter/material.dart';
import 'package:zabihtk/app_repo/app_state.dart';

  class NotificationProvider extends ChangeNotifier {
    Services _services = Services();

    User _currentUser;
    String _currentLang;
    AppState _appState;


    void update(AppState appState) {
      _currentUser = appState.currentUser;
      _currentLang = appState.currentLang;
    }


    Future<List<NotificationMsg>> getMessageList() async {


    final response = await _services.get('https://zabihalbetak.com/app/api/my_inbox1?user_id=${_currentUser.userId}');
    List<NotificationMsg> messageList = List<NotificationMsg>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      messageList = iterable.map((model) => NotificationMsg.fromJson(model)).toList();
    }

    return messageList;
  }

  }