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
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;
import 'package:validators/validators.dart';

class Transfer extends StatefulWidget {
  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {

  double _height = 0, _width = 0;
  ProgressIndicatorState _progressIndicatorState;
  LocationState _locationState;
  File _imageFile;
  final _picker = ImagePicker();
  bool _isLoading = false;
  dynamic _pickImageError;
  Bank _selectedBank;
  Services _services = Services();
  Future<List<Bank>> _bankList;
  bool _initialRun = true;
  AppState _appState;
  PaymentState _paymentState;
  final _imagePicker = ImagePicker();
  String _bankName = '' , _bankAcount = '', _bankIban = '';


  final _formKey = GlobalKey<FormState>();
  String _accountOwner = '', _accountNo = '', _iban = '' , _imgIsDetected = '';

  Future<List<Bank>> _getBankList() async {
    Map<String, dynamic> results =
    await _services.get('${Utils.BANKS_URL}lang=${_appState.currentLang}');
    List bankList = List<Bank>();
    if (results['response'] == '1') {
      Iterable iterable = results['bank'];
      bankList = iterable.map((model) => Bank.fromJson(model)).toList();
    } else {
      showErrorDialog(results['message'], context);
    }
    return bankList;
  }


  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile = File(pickedFile.path);
      if(_imageFile != null){

      }

    } catch (e) {
      _pickImageError = e;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _paymentState = Provider.of<PaymentState>(context);
      _locationState = Provider.of<LocationState>(context);
      _bankList = _getBankList();
      _initialRun = false;
    }
  }



  Future<void> _retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      _imageFile = response.file;
    } else {
      _pickImageError = response.exception.code;
    }
  }

  Widget _buildRow(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: cBlack, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          Text(
            value,
            style: TextStyle(
                color: cBlack, fontSize: 14, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        height: _height  *1.1,
        width: _width,
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(15)),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: _width * 0.05, vertical: 5),
                  child: Text(
                    AppLocalizations.of(context).transferDate,
                    style: TextStyle(color: cBlack, fontSize: 16),
                  ),
                ),

                Container(
                  height: 75,
                  margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
                  width: _width,
                  child: FutureBuilder<List<Bank>>(
                    future: _bankList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var banklist = snapshot.data.map((item) {
                          return new DropdownMenuItem<Bank>(
                            child: new Text(item.bankTitle),
                            value: item,
                          );
                        }).toList();
                        return DropDownListSelector(
                          validationFunc: (value) {
                            if (_selectedBank == null) {
                              return AppLocalizations.of(context)
                                  .bankValidation;
                            }
                            return null;
                          },
                          dropDownList: banklist,
                          hint: AppLocalizations.of(context).bankName,
                          onChangeFunc:  (newValue) {
                            setState(() {
                              _selectedBank = newValue;
                              _bankName = _selectedBank.bankName;
                              _bankAcount = _selectedBank.bankAcount;
                              _bankIban = _selectedBank.bankIban;
                            });
                          },
                          value: _selectedBank,
                        );
                      }
                      return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: cPrimaryColor,
                          ));
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: _width *0.1),
                  child: Text( AppLocalizations.of(context).bankAccountDetails,style: TextStyle(
                      color: cBlack,fontSize: 13
                  ),) ,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: _width *0.08),
                    child:    _buildRow(
                        '${AppLocalizations.of(context).accountOwner}   :   ',
                        _bankName
                    )),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: _width *0.08),
                  child:       _buildRow(
                      '${AppLocalizations.of(context).accountNumber}       :   ',
                      _bankAcount
                  ),),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: _width *0.08),
                  child:     _buildRow(
                      '${AppLocalizations.of(context).iban}         :   ',
                      _bankIban
                  ),),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: _width,
                  child: CustomTextFormField(
                      hintTxt: AppLocalizations.of(context).nameOfTransferAccountHolder,
                      inputData: TextInputType.text,
                      onChangedFunc: (String text) {
                        _accountOwner = text;
                      },
                      validationFunc: (value) {
                        if (value.trim().length == 0) {
                          return AppLocalizations.of(context)
                              .nameOfTransferAccountHolder;
                        }
                        return null;
                      }),
                ),
                Container(
                  width: _width,
                  margin: EdgeInsets.only(top: 20),
                  child: CustomTextFormField(
                      hintTxt: AppLocalizations.of(context).accountNumberOfTransferHolder,
                      inputData: TextInputType.number,
                      onChangedFunc: (String text) {
                        _accountNo = text;
                      },
                      validationFunc: (value) {
                        if (value.trim().length == 0 || !isNumeric(value)) {
                          return AppLocalizations.of(context)
                              .accountNumberOfTransferHolder;
                        }
                        return null;
                      }),
                ),
                // Container(
                //   width: _width,
                //   margin: EdgeInsets.only(top: 20),
                //   child: CustomTextFormField(
                //       hintTxt: AppLocalizations.of(context).iban,
                //       inputData: TextInputType.number,
                //       onChangedFunc: (String text) {
                //         _iban = text;
                //       },
                //       validationFunc: (value) {
                //         if (_iban.trim().length == 0) {
                //           return AppLocalizations.of(context).ibanValidation;
                //         }
                //         else if()
                //         return null;
                //       }),
                // ),
                Container(
                    height: 20,
                    margin: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: _width * 0.07,
                        left: _width * 0.07),
                    child: Text(
                      AppLocalizations.of(context).hawalaImageValidation,
                      style: TextStyle(
                          fontSize: 15,
                          color: cHintColor,
                          fontWeight: FontWeight.w400),
                    )),
                Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(
                        right: _width * 0.07, left: _width * 0.07),
                    height: 40,

                    child: Row(
                      children: <Widget>[
                        FloatingActionButton(
                            shape:
                            CircleBorder(side: BorderSide(color: cHintColor)),
                            backgroundColor: cWhite,
                            elevation: 0,
                            onPressed: () {
                              _onImageButtonPressed(ImageSource.gallery,
                                  context: context);
                            },
                            heroTag: 'image0',
                            tooltip: 'Pick Image from gallery',
                            child: Platform.isAndroid
                                ? FutureBuilder<void>(
                                future: _retrieveLostData(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<void> snapshot) {
                                  return const Icon(
                                    Icons.photo_library,
                                    color: Color(0xff606261),
                                  );
                                })
                                : const Icon(
                              Icons.photo_library,
                              color: Color(0xff606261),
                            )),
                        Text(_imgIsDetected ,style: TextStyle(
                            color: cBlack, fontSize: 14
                        ),)

                      ],
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
                  child: Divider(
                    height: 30,
                  ),
                ),


                Container(
                    margin: EdgeInsets.only(
                        top: 20,
                        left: _width * 0.07,
                        right: _width * 0.07,
                        bottom: 10),
                    child: CustomButton(
                        btnLbl: AppLocalizations.of(context).orderConfirmation,
                        onPressedFunction: () async {


                          FormData formData = new FormData.fromMap({
                            "imgURL": _imageFile != null ? await MultipartFile.fromFile(_imageFile.path,
                                filename: Path.basename(_imageFile.path)) : null,
                            "user_id": _appState.currentUser.userId,
                            "cartt_phone": _paymentState.userPhone,
                            "cartt_adress": _locationState.address,
                            "cartt_mapx": _locationState.locationLatitude,
                            "cartt_mapy":_locationState.locationlongitude,
                            "cartt_name": _accountOwner,
                            "cartt_bank":_selectedBank.bankId,
                            "cartt_acount":_accountNo,
                            "cartt_tawsil":_appState.checkedValue,
                            "cartt_tawsil_value":_appState.currentTawsil,
                            "lang":_appState.currentLang
                          });
                          final results = await _services
                              .postWithDio(Utils.BASE_URL +'convert_go'+ "?api_lang=${_appState.currentLang}", body: formData);
                          setState(() => _isLoading = false);

                          if (results['response'] == "1") {
                            showToast(results['message'], context);
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context,  '/navigation');
                          } else {
                            showErrorDialog(results['message'], context);
                          }

                        }))
              ]),
        ),
      ),
    );
  }
}
