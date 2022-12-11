import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zabihtk/app_data/shared_preferences_helper.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/app_repo/auth_state.dart';
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

class CitiesScreen extends StatefulWidget {
  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  double _height = 0, _width = 0;

  String _userName = '', _userEmail = '', _userPhone = '', _userPassword = '' ,_userPasswordVerify = '';
  Services _services = Services();
  ProgressIndicatorState _progressIndicatorState;
  AppState _appState;
  Future<List<City>> _cityList;
  City _selectedCity;
  bool _initialRun = true;
  AuthState _authState;


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
      _cityList = _getCityList();
      _initialRun = false;
    }
  }

  bool _checkValidation(BuildContext context,{String  userName ,
    String userPhone , String userPassword ,
    String userPasswordVerify ,City  selectedCity}) {
    if (userName.trim().length == 0) {
      showToast(
          AppLocalizations.of(context).nameValidation,
          context,
          color: cRed
      );
      return false;
    }  else if (!isNumeric(userPhone)) {
      showToast(
          AppLocalizations.of(context).phonoNoValidation,
          context,
          color: cRed
      );
      return false;
    } else if (selectedCity == null) {
      showToast(
          AppLocalizations.of(context).cityValidation,
          context,
          color: cRed
      );
      return false;
    } else if (_userPassword.trim().length == 0) {
      showToast(AppLocalizations.of(context).passwordValidation, context,   color: cRed);
      return false;
    } else if (userPasswordVerify != _userPassword) {
      showToast(AppLocalizations.of(context).passwordNotIdentical, context,   color: cRed);
      return false;
    } else {
      return true;
    }
  }

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 120,
        ),

        Image.asset(
          'assets/images/logo.png',
          height: 150,
          width: _width,
        ),

        SizedBox(
          height: 10,
        ),
        Text(_appState.currentLang=='ar'?"اختار مدينتك من القائمة التالية":"Choose your city from the following list",style: TextStyle(fontSize: 22),textAlign: TextAlign.center,),
        SizedBox(
          height: 10,
        ),
        // Container(
        //     margin: EdgeInsets.only(
        //       top: 10,
        //     ),
        //     child: CustomTextFormField(
        //        prefixIconIsImage: true,
        //       prefixIconImagePath: 'assets/images/email.png',
        //       hintTxt: AppLocalizations.of(context).email,

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

                          availableErrorMsg: false,
                          dropDownList: cityList,
                          hint: AppLocalizations.of(context).city,
                          onChangeFunc: (newValue) {
                            _appState.setCurrentCity(newValue);
                            _appState.setCurrentTawsil(_appState.currentCity.cityTawsil);
                            setState(() {
                              _selectedCity = newValue;
                            });
                          },
                          value: _selectedCity,

                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: cPrimaryColor,
                          ));
                    },
                  )))
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(5)),




        Container(
          margin: EdgeInsets.only(top: 10),
          child: CustomButton(
            btnLbl: _appState.currentLang=='ar'?"اختيار":"Select",
            onPressedFunction: () {
             if(_appState.currentCity==null){
               showToast(_appState.currentLang=='ar'?"قم باختيار مدينتك":"Select your city", context);
             }else{
               Navigator.pushReplacementNamed(context,  '/navigation');
             }


            },
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(

        backgroundColor: cPrimaryColor,
        centerTitle: true,
        title: Text(_appState.currentLang=='ar'?"اختيار مدينتك":"Select your city",
            style: Theme.of(context).textTheme.display1),
);
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _appState = Provider.of<AppState>(context);
    _authState = Provider.of<AuthState>(context);

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
            ),
          ),
        ));
  }
}
