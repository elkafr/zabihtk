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

class Visa extends StatefulWidget {
  @override
  _VisaState createState() => _VisaState();
}

class _VisaState extends State<Visa> {



  double _height = 0, _width = 0;
  ProgressIndicatorState _progressIndicatorState;
  LocationState _locationState;
  File _imageFile;
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _bankList = _getBankList();
      _initialRun = false;
    }
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await  _imagePicker.getImage(
        source: source,
      );
      setState(() {
        _imageFile = File(pickedFile.path);
        if(_imageFile != null){
          _imgIsDetected = AppLocalizations.of(context).detectImg;
        }
      });

    } catch (e) {
      _pickImageError = e;
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

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(100),
        child: Center(
          child: Text(AppLocalizations.of(context).soon,style: TextStyle(fontSize: 25,color: cPrimaryColor),),
        )
      ),
    );
  }
}
