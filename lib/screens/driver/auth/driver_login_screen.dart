import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:zabihtk/app_data/shared_preferences_helper.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/app_repo/driver_navigation_state.dart';
import 'package:zabihtk/app_repo/progress_indicator_state.dart';
import 'package:zabihtk/components/buttons/custom_button.dart';
import 'package:zabihtk/components/connectivity/network_indicator.dart';
import 'package:zabihtk/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:zabihtk/components/dialogs/restore_password_dialog.dart';
import 'package:zabihtk/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:zabihtk/components/response_handling/response_handling.dart';
import 'package:zabihtk/components/safe_area/page_container.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/models/user.dart';
import 'package:zabihtk/services/access_api.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class DriverLoginScreen extends StatefulWidget {
  @override
  _DriverLoginScreenState createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {
  double _height = 0,_width = 0;
  final _formKey = GlobalKey<FormState>();
  String _userPhone = '', _userPassword = '';
  Services _services = Services();
  ProgressIndicatorState _progressIndicatorState;
  AppState _appState;
  DriverNavigationState _driverNavigationState;
  bool _isLoading = false;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

   bool _checkValidation(BuildContext context, {String phone, String password}) {
    if (phone.trim().length == 0) {
      showToast(AppLocalizations.of(context).phonoNoValidation, context,
          color: cRed);
      return false;
    }
    // else if (password.trim().length < 4) {
    //   showToast(AppLocalizations.of(context).passwordValidation, context,
    //       color: cRed);
    //   return false;
    // }
    return true;
  }

  Widget _buildBodyItem(){
    return  ListView(

          children: <Widget>[
 SizedBox(
   height: 50,
 ),
 Image.asset('assets/images/logo.png',height: 150,width: _width,
 ),
 Container(
   margin: EdgeInsets.only(
         top: 20
   ),
   child: CustomTextFormField(
                        prefixIconIsImage: true,
                        prefixIconImagePath: 'assets/images/phone.png',
                        hintTxt: AppLocalizations.of(context).phoneNo,
                        inputData: TextInputType.text,
                        onChangedFunc: (String text) {
                           _userPhone = text.toString();
                        },

                      ),
 ),
  Container(
   margin: EdgeInsets.only(
         top: 15
   ),
   child: CustomTextFormField(
                        prefixIconIsImage: true,
                        isPassword: true ,
                        prefixIconImagePath: 'assets/images/key.png',
                        hintTxt: AppLocalizations.of(context).password,
                        inputData: TextInputType.text,
                        onChangedFunc: (String text) {
                           _userPassword = text.toString();
                        },

                      ),),

                       Container(
                    margin: EdgeInsets.only(
                        top: 10,

                        right: _width * 0.08,
                        left: _width * 0.08),
                    height:30 ,
                    child: GestureDetector(
                        onTap: () {
                   showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (_) {
                          return RestorePasswordDialog(

                          );
                        });
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: cBlack, fontSize: 16, fontFamily: 'HelveticaNeueW23forSKY'),
                            children: <TextSpan>[
                              TextSpan(text: AppLocalizations.of(context).forgetPassword),
                              TextSpan(
                                text: AppLocalizations.of(context).clickHere,
                                style: TextStyle(
                                    color: cAccentColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    fontFamily: 'HelveticaNeueW23forSKY'),
                              ),
                            ],
                          ),
                        ))),


               CustomButton(
                    btnLbl: AppLocalizations.of(context).login,
                 onPressedFunction: () async {

                     _firebaseMessaging.getToken().then((token) async {
                       print('token: $token');

                       setState(() {
                         _isLoading = true;
                       });
                       final results = await _services.get(
                         '${Utils.LOGIN_URL}?user_phone=$_userPhone&user_pass=$_userPassword&lang=${_appState.currentLang}&token=$token&user_type=driver',
                       );

                       setState(() => _isLoading = false);
                       if (results['response'] == "1") {
                         _appState.setCurrentUser(
                             User.fromJson(results['user_details']));
                         SharedPreferencesHelper.save(
                             "user", _appState.currentUser);
                         showToast(results['message'], context);
                         _driverNavigationState.upadatedriverNavigationIndex(0);
                         Navigator.of(context).pushNamedAndRemoveUntil(
                             '/driver_navigation', (Route<dynamic> route) => false);
                       } else {
                         showErrorDialog(results['message'], context);

                       }
                     });

                 },
                  ),


          ],

    );
  }
  @override
  Widget build(BuildContext context) {
      final appBar = AppBar(
      backgroundColor: cPrimaryColor,
        centerTitle: true,
        title: Text( AppLocalizations.of(context).login,
            style: Theme.of(context).textTheme.display1),
        leading: IconButton(
          icon: Consumer<AppState>(
            builder: (context,appState,child){
              return appState.currentLang == 'ar' ? Image.asset('assets/images/back_ar.png'):
              Image.asset('assets/images/back_en.png');

            }
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
          _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _appState = Provider.of<AppState>(context);
      _driverNavigationState = Provider.of<DriverNavigationState>(context);



    return   NetworkIndicator(child: PageContainer(
      child: Scaffold(
        appBar: appBar,
        body: Stack(
          children: <Widget>[
            _buildBodyItem(),
              Center(
            child: ProgressIndicatorComponent(),
          )
          ],
        ),

      ),
    ));
  }
}