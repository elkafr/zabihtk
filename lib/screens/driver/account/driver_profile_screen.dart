import 'package:flutter/material.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/components/buttons/custom_button.dart';
import 'package:zabihtk/components/connectivity/network_indicator.dart';
import 'package:zabihtk/components/safe_area/page_container.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/components/dialogs/log_out_dialog.dart';
import 'package:zabihtk/app_data/shared_preferences_helper.dart';
import 'package:zabihtk/app_repo/driver_navigation_state.dart';
import 'package:zabihtk/screens/home/home_screen.dart';

import 'package:provider/provider.dart';

class DriverProfileScreen extends StatefulWidget {
  @override
  _DriverProfileScreenState createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  double _height, _width;

  AppState _appState;
   DriverNavigationState _driverNavigationState;

  Widget _buildRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 5),
          child: Text(
            title,
            style: TextStyle(color: cBlack, fontSize: 16),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            value,
            style: TextStyle(color: cBlack, fontSize: 16),
          ),
        )
      ],
    );
  }

  Widget _buildBodyItem() {
    return Stack(
      children: <Widget>[
        Container(
          color: cPrimaryColor,
          height: 50,
        ),
        Positioned(
            child: SingleChildScrollView(
                child: Center(
          child: Container(
              decoration: BoxDecoration(
                color: cWhite,
                borderRadius: BorderRadius.all(
                  const Radius.circular(15.00),
                ),
                border: Border.all(color: Color(0xff015B2A1A)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff015B2A1A).withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: _height * .80,
              width: _width * .90,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    _buildRow('${AppLocalizations.of(context).name}     :',
                        _appState.currentUser.userName),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        height: 30,
                      ),
                    ),
                    _buildRow(
                        '${AppLocalizations.of(context).phoneNo}          :',
                        _appState.currentUser.userPhone),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        height: 30,
                      ),
                    ),
                    _buildRow('${AppLocalizations.of(context).email}   :',
                        _appState.currentUser.userEmail),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        height: 30,
                      ),
                    ),
                    _buildRow(
                        '${AppLocalizations.of(context).driverAdress}   :',
                        _appState.currentUser.userAdress),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        height: 30,
                      ),
                    ),
                    _buildRow(
                        '${AppLocalizations.of(context).driverDrivers}   :',
                        (_appState.currentUser.userNumber.toString() ==
                                null)
                            ? '0'
                            : _appState.currentUser.userNumber.toString()),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: _width * 0.35,
                              height: 50,
                              child: CustomButton(
                                  buttonOnDialog: true,
                                  btnStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: cWhite),
                                  btnLbl: AppLocalizations.of(context).editInfo,
                                  onPressedFunction: () {
                                    Navigator.pushNamed(context,
                                        '/modify_personal_info_screen');
                                  }),
                            ),
                            Container(
                              width: _width * 0.35,
                              height: 50,
                              child: CustomButton(
                                buttonOnDialog: true,
                                btnStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: cAccentColor),
                                btnLbl:
                                    AppLocalizations.of(context).editPassword,
                                btnColor: cWhite,
                                borderColor: cAccentColor,
                                onPressedFunction: () {
                                  Navigator.pushNamed(
                                      context, '/modify_password_screen');
                                },
                              ),
                            )
                          ]),
                    )
                  ])),
        )))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _appState = Provider.of<AppState>(context);
    final appBar = AppBar(
      centerTitle: true,
      title: Text(AppLocalizations.of(context).personalInfo,
          style: Theme.of(context).textTheme.display1),
      actions: <Widget>[
        GestureDetector(
          child: Image.asset('assets/images/logoutwh.png'),
          onTap: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (_) {
                  return LogoutDialog(
                    alertMessage: AppLocalizations.of(context).wantToLogout,
                    onPressedConfirm: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/navigation');
                    },
                  );
                });
          },
        )
      ],
      elevation: 0,
    );

    _height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
      child: Scaffold(
        appBar: appBar,
        body: _buildBodyItem(),
      ),
    ));
  }
}
