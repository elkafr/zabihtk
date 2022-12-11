import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zabihtk/app_data/shared_preferences_helper.dart';
import 'package:zabihtk/app_repo/app_state.dart';
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
import 'package:zabihtk/models/city.dart';
import 'package:zabihtk/models/user.dart';
import 'package:zabihtk/services/access_api.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class ModifyPersonalInfoScreen extends StatefulWidget {
  @override
  _ModifyPersonalInfoScreenState createState() =>
      _ModifyPersonalInfoScreenState();
}

class _ModifyPersonalInfoScreenState extends State<ModifyPersonalInfoScreen> {
  double _height, _width;
  bool _initialRun = true;
  ProgressIndicatorState _progressIndicatorState;
  AppState _appState;
  Future<List<City>> _cityList;
  City _selectedCity;
  Services _services = Services();
  String _userName = '', _userEmail = '', _userPhone = '';

  Future<List<City>> _getCityList() async {
    Map<String, dynamic> results =
        await _services.get(Utils.CITIES_URL, header: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': _appState.currentLang
    });
    List<City> cityList = List<City>();
    if (results['response'] == '1') {
      Iterable iterable = results['city'];
      cityList = iterable.map((model) => City.fromJson(model)).toList();
    } else {
      showErrorDialog(results['msg'], context);
    }
    return cityList;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _userName = _appState.currentUser.userName;
      _userEmail = _appState.currentUser.userEmail;
      _userPhone = _appState.currentUser.userPhone;
       _cityList = _getCityList();
      _initialRun = false;
    }
  }

  bool _checkValidation(BuildContext context,
      {String name, String phone, String email, City city}) {
    if (name.trim().length < 4) {
      showToast(AppLocalizations.of(context).nameValidation, context,color: cRed);
      return false;
    } else if (phone.trim().length == 0) {
      showToast(AppLocalizations.of(context).phonoNoValidation, context,color: cRed);
      return false;
    } else if (!isEmail(email)) {
      showToast(AppLocalizations.of(context).emailValidation, context,color: cRed);
      return false;
    } else if (city == null) {
      showToast(AppLocalizations.of(context).cityValidation, context,color: cRed);
      return false;
    }

    return true;
  }

  Widget _buildBodyItem() {
    return SingleChildScrollView(
        child: Container(
            height: _height,
            width: _width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextFormField(
                    initialValue: _appState.currentUser.userName,
                    prefixIconIsImage: true,
                    prefixIconImagePath: 'assets/images/profile.png',
                    hintTxt: AppLocalizations.of(context).name,
                    onChangedFunc: (String text) {
                      _userName = text;
                    },
                    inputData: TextInputType.text,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: CustomTextFormField(
                        initialValue: _appState.currentUser.userPhone,
                        prefixIconIsImage: true,
                        prefixIconImagePath: 'assets/images/phone.png',
                        hintTxt: AppLocalizations.of(context).phoneNo,
                        onChangedFunc: (String text) {
                          _userPhone = text;
                        },
                        inputData: TextInputType.number,
                      )),
                  // Container(
                  //     margin: EdgeInsets.only(
                  //       top: 10,
                  //     ),
                  //     child: CustomTextFormField(
                  //        prefixIconIsImage: true,
                  //       prefixIconImagePath: 'assets/images/email.png',
                  //       hintTxt: AppLocalizations.of(context).email,
                  //       initialValue: _appState.currentUser.userEmail,
                  //       inputData: TextInputType.text,
                  //       onChangedFunc: (String text) {
                  //         _userEmail = text;
                  //       },
                  //     )),
                 Container(
                   height: 45,
                   padding: EdgeInsets.symmetric(
                       horizontal: MediaQuery.of(context).size.width * 0.03),
                   margin:EdgeInsets.symmetric(
                       horizontal: MediaQuery.of(context).size.width * 0.08),

                   decoration: BoxDecoration(
                     color:   cWhite,
                     borderRadius: BorderRadius.circular(100.0),
                     border: Border.all(color: cHintColor),
                   ),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Image.asset('assets/images/location.png'),
                       Padding(padding: EdgeInsets.all(5)),
                       Expanded(child: Container(
                   
                           child: FutureBuilder<List<City>>(
                             future: _cityList,
                             builder: (context, snapshot) {
                               if (snapshot.hasData) {
                                 var cityList = snapshot.data.map((item) {
                                   return new DropdownMenuItem<City>(
                                     child: new Text(item.cityName),
                                     value: item,
                                   );
                                 }).toList();
                                 return DropDownListSelector(
                                   dropDownList: cityList,
                                   hint: AppLocalizations.of(context).city,
                                   onChangeFunc: (newValue) {
                                     setState(() {
                                       _selectedCity = newValue;
                                     });
                                   },
                                   value: _selectedCity,
                                 );
                               } else if (snapshot.hasError) {
                                 return Text("${snapshot.error}");
                               }

                               return DefaultShapeOfDropDown(
                                 hint: AppLocalizations.of(context).city,
                               );
                             },
                           )))
                     ],
                   ),
                 ),
                  Spacer(),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: CustomButton(
                          btnLbl: AppLocalizations.of(context).save,
                          onPressedFunction: () async {
                            if (_checkValidation(context,
                                name: _userName,
                                email: _userEmail,
                                phone: _userPhone,
                                city: _selectedCity)) {
                         var results = await _services.get(
                          '${Utils.UPDATE_PROFILE_URL}user_email=$_userEmail&user_name=$_userName&user_phone=$_userPhone&user_id=${_appState.currentUser.userId}&lang=${_appState.currentLang}',
                        );
                        _progressIndicatorState.setIsLoading(false);
                        if (results['response'] == '1') {

                          _appState.updateUserEmail(_userEmail);
                          _appState.updateUserName(_userName);
                          _appState.updateUserPhone(_userPhone);
                          _appState.updateUserCity(_selectedCity);
                              SharedPreferencesHelper.save(
                                  "user", _appState.currentUser);
                                  showToast( results['message'], context);
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(context, '/profile_screen');
                        } else {
                          showErrorDialog(results['message'], context);
                        }
                            }
                          }))
                ])));
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      title: Text(AppLocalizations.of(context).editInfo,
          style: Theme.of(context).textTheme.display1),
      leading: GestureDetector(
        child: Consumer<AppState>(
            builder: (context,appState,child){
              return appState.currentLang == 'ar' ? Image.asset('assets/images/back_ar.png'):
              Image.asset('assets/images/back_en.png');

            }
          ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  
    _height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
                appBar: appBar,
                body: Stack(
                  children: <Widget>[
                    _buildBodyItem(),
                    Center(
                      child: ProgressIndicatorComponent(),
                    )
                  ],
                ))));
  }
}
