import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/app_repo/location_state.dart';
import 'package:zabihtk/app_repo/payment_state.dart';
import 'package:zabihtk/app_repo/progress_indicator_state.dart';
import 'package:zabihtk/components/connectivity/network_indicator.dart';
import 'package:zabihtk/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:zabihtk/components/dialogs/location_dialog.dart';

import 'package:zabihtk/components/not_registered/not_registered.dart';
import 'package:zabihtk/components/option_title/option_title.dart';
import 'package:zabihtk/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:zabihtk/components/response_handling/response_handling.dart';
import 'package:zabihtk/components/safe_area/page_container.dart';
import 'package:zabihtk/components/title_item/title_item.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/models/cart.dart';

import 'package:zabihtk/services/access_api.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/utils/utils.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:zabihtk/components/no_data/no_data.dart';
import 'package:validators/validators.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _height = 0, _width = 0;
  Services _services = Services();
  AppState _appState;
  bool _initialRun = true;
  String _userPhone = '';
  ProgressIndicatorState _progressIndicatorState;
  Future<List<Cart>> _cartList;
  int _totalCost = 0;
  LocationState _locationState;
  LocationData _locData;
  PaymentState _paymentState;
  bool checkedValue=false;



  Future<List<Cart>> _getCartList() async {
    Map<String, dynamic> results =
        await _services.get('${Utils.SHOW_CART_URL}${_appState.currentUser.userId}&lang=${_appState.currentLang}&city_id=${_appState.currentCity.cityId}');
 
    List<Cart> cartList = List<Cart>();
    if (results['response'] == '1') {
      Iterable iterable = results['ads'];
      cartList = iterable.map((model) => Cart.fromJson(model)).toList();
      if (cartList.length > 0) {
        _totalCost = 0;
        for (int i = 0; i < cartList.length; i++) {
          _totalCost += (cartList[i].price*cartList[i].cartAmount);
        }
      }
    } else {
      print('error');
    }
    return cartList;
  }

  bool _checkValidation(BuildContext context, {String phone ,String address}) {
    if (phone.trim().length == 0|| !isNumeric(phone)) {
      showToast(AppLocalizations.of(context).phonoNoValidation, context,
          color: cRed);
      return false;
    }else if (address == AppLocalizations.of(context).pleaseEnterYourLocation || address == null) {
      showToast(AppLocalizations.of(context).pleaseEnterYourLocation, context,
          color: cRed);
      return false;
    }

    return true;
  }

  Future<void> _getCurrentUserLocation() async {
    _progressIndicatorState.setIsLoading(true);
     _locData = await Location().getLocation();
    print(_locData.latitude);
    print(_locData.longitude);

    if(_locData != null){
      _locationState.setLocationLatitude(_locData.latitude);
      _locationState.setLocationlongitude(_locData.longitude);
       List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
                 _locationState.locationLatitude, _locationState
   .locationlongitude);
  _locationState.setCurrentAddress(placemark[0].name + '  ' + placemark[0].administrativeArea + ' '
   + placemark[0].country);
  //  final coordinates = new Coordinates(_locationState.locationLatitude, _locationState
  //  .locationlongitude);
        // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        // var first = addresses.first;
        _progressIndicatorState.setIsLoading(false);
      // _locationState.setCurrentAddress(first.addressLine);
        
      
        // print("${first.featureName} : ${first.addressLine}");
         showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (_) {
                          return LocationDialog(
                      
                          );
                        });

    }
  
  }
 
  @override
  void didChangeDependencies() {
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _locationState = Provider.of<LocationState>(context);
      _cartList = _getCartList();
        _locationState.initCurrentAddress(AppLocalizations.of(context).pleaseEnterYourLocation);
        _appState.setCheckedValue("1");
      _initialRun = false;
    }
    super.didChangeDependencies();
  }



  Widget _buildCartItem(Cart cart) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: EdgeInsets.all(10),
      height: 190,
      decoration: BoxDecoration(
        color: cWhite,
        borderRadius: BorderRadius.all(
          const Radius.circular(15.00),
        ),
        border: Border.all(color: Color(0xff015B2A1A)),    boxShadow: [
        BoxShadow(
          color: Color(0xff015B2A1A).withOpacity(0.1),
          spreadRadius: 3,
          blurRadius: 5,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                cart.title,
                style: TextStyle(
                    color: cBlack, fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Container(
                height: 1,
                width: _width * 0.6,
                color: Colors.grey[300],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: OptionTitle( title:
                    AppLocalizations.of(context).croping,value: cart.options2Name),
              ),
              OptionTitle( title:AppLocalizations.of(context).encupsulation,
                value:  cart.options3Name),
              OptionTitle(
                 title: AppLocalizations.of(context).headAndSeat,value: cart.options4Name),
              OptionTitle( title:AppLocalizations.of(context).rumenAndInsistence,
              value:    cart.options5Name),
              Spacer(
                flex: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cart.cartAmount++;
                        _totalCost += cart.price;
                      });
                         print('NUMBER: ${cart.cartAmount}');
                            _services.get('${Utils.UPDATE_AMOUNT_URL}cart_amount=${cart.cartAmount}&cart_id=${cart.cartId}');
                    },
                    child: Image.asset('assets/images/plus.png'),
                  ),
                  Container(
                      height: 35,
                      width: _width * 0.17,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.00),
                          ),
                          border: Border.all(color: cHintColor)),
                      child: Text(
                        cart.cartAmount.toString(),
                        style: TextStyle(
                            color: cPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      )),
                  GestureDetector(
                    onTap: () {
                        if (cart.cartAmount > 1) {
                      setState(() {
                          cart.cartAmount--;
                          _totalCost -= cart.price;
                        
                      });
                    
                        print('NUMBER: ${cart.cartAmount}');
                        _services.get(Utils.UPDATE_AMOUNT_URL+'cart_amount=${cart.cartAmount}&cart_id=${cart.cartId}');
                        }
                    },
                    child: Image.asset('assets/images/minus.png'),
                  ),
                ],
              ),
              Spacer(
                flex: 1,
              )
            ],
          ),
          Spacer(),
          Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: cPrimaryColor,
                radius: 45,
                backgroundImage: NetworkImage(cart.adsMtgerPhoto),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: cAccentColor,
                          fontSize: 16,
                          fontFamily: 'HelveticaNeueW23forSKY'),
                      children: <TextSpan>[
                        TextSpan(text: (cart.price*cart.cartAmount).toString() ),
                        TextSpan(text: '  '),
                        TextSpan(
                          text: AppLocalizations.of(context).sr,
                          style: TextStyle(
                              color: cAccentColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              fontFamily: 'HelveticaNeueW23forSKY'),
                        ),
                      ],
                    ),
                  )),
              GestureDetector(
                onTap: () async {
                    _progressIndicatorState.setIsLoading(true);
                              var results = await _services.get(
                                '${Utils.DELETE_FROM_CART_URL}user_id=${_appState.currentUser.userId}&cart_id=${cart.cartId}&lang=${_appState.currentLang}',
                              );
                              _progressIndicatorState.setIsLoading(false);
                              if (results['response'] == '1') {
                                showToast(results['message'], context);
                             _cartList = _getCartList();
                            //  setState(() {
                            //    _totalCost =_totalCost - (cart.price * cart.cartAmount);
                            //   });
                               
                              } else {
                                showErrorDialog(results['message'], context);
                              }
                },
                child: Container(
                    width: _width * 0.15,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(6.00),
                        ),
                        border: Border.all(color: cHintColor)),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).delete,
                        style: TextStyle(
                            color: Color(0xffBF0001),
                            fontWeight: FontWeight.w700),
                      ),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBodyItem() {
    return FutureBuilder<List<Cart>>(
        future: _cartList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
           if(snapshot.data.length >0){
                 return ListView(
              children: <Widget>[
                Container(
                    height: _height * 0.55,
                    padding: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return _buildCartItem(snapshot.data[index]);
                        })),
                TitleItem(
                  title: AppLocalizations.of(context).detectLocation,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                       
                           _getCurrentUserLocation();
                        },
                        child: Container(
                          width: _width * 0.25,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: cPrimaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.00),
                              ),
                              border: Border.all(color: cPrimaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 5,right: 5),
                                child: Image.asset(
                                  'assets/images/cursor.png',
                                  color: cWhite,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context).detect,
                                style: TextStyle(
                                    color: cWhite,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: _width *0.6,

                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                     _locationState.address,
                          maxLines: 2,
                          style: TextStyle(
                            
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffB7B7B7)),
                              overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                TitleItem(
                  title: AppLocalizations.of(context).enterPhoneNo,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: CustomTextFormField(
                    buttonOnTextForm: true,
                    prefixIconIsImage: true,
                    prefixIconImagePath: 'assets/images/phone.png',
                    hintTxt: AppLocalizations.of(context).phoneNo,
                    inputData: TextInputType.text,
                    onChangedFunc: (String text) {
                      _userPhone = text.toString();
                    },
                  ),
                ),

                TitleItem(
                  title: "الوقت المناسب للتوصيل",
                ),
                Container(
                  margin: EdgeInsets.only(right: _width*.08,left: _width*.08,top: 10),
                  alignment: Alignment.centerRight,

                  child: Row(

                    children: <Widget>[
                      Text("الصباح من 10 ص الى 1 م"),
                  Spacer(),
                  _appState.checkedValue=="1"?GestureDetector(
                        onTap: (){
                          _appState.setCheckedValue(null);
                        },
                        child: Icon(Icons.check_circle,color: cPrimaryColor,size: 30,),
                      ):GestureDetector(
                    onTap: (){
                      _appState.setCheckedValue("1");
                      print(_appState.checkedValue);
                    },
                    child: Icon(Icons.check_circle,color: Colors.grey[300],size: 30,),
                  )
                    ],
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(right: _width*.08,left: _width*.08,top: 10),
                  alignment: Alignment.centerRight,

                  child: Row(

                    children: <Widget>[
                      Text("الظهر من 1 م الى 5 م"),
                      Spacer(),
                      _appState.checkedValue=="2"?GestureDetector(
                        onTap: (){
                          _appState.setCheckedValue(null);
                        },
                        child: Icon(Icons.check_circle,color: cPrimaryColor,size: 30,),
                      ):GestureDetector(
                        onTap: (){
                          _appState.setCheckedValue("2");
                          print(_appState.checkedValue);
                        },
                        child: Icon(Icons.check_circle,color: Colors.grey[300],size: 30,),
                      )
                    ],
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(right: _width*.08,left: _width*.08,top: 10),
                  alignment: Alignment.centerRight,

                  child: Row(

                    children: <Widget>[
                      Text("المساء من 5 م الى 9 م"),
                      Spacer(),
                      _appState.checkedValue=="3"?GestureDetector(
                        onTap: (){
                          _appState.setCheckedValue(null);
                        },
                        child: Icon(Icons.check_circle,color: cPrimaryColor,size: 30,),
                      ):GestureDetector(
                        onTap: (){
                          checkedValue = true;
                          _appState.setCheckedValue("3");
                          print(_appState.checkedValue);
                        },
                        child: Icon(Icons.check_circle,color: Colors.grey[300],size: 30,),
                      )
                    ],
                  ),
                ),






                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.00),
                        ),
                        border: Border.all(color: cHintColor)),
                    margin: EdgeInsets.only(
                        bottom: 20, left: 10, right: 10, top: 10),
                    child: Column(
                      children: <Widget>[




                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 30,
                                  width: _width * 0.26,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.00),
                                      ),
                                      color: cAccentColor),
                                  child: Text(
                                    _appState.currentLang=="ar"?"قيمة الطلبات":"value of orders",
                                    style: TextStyle(
                                        color: cWhite,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: cBlack,
                                      fontSize: 16,
                                      fontFamily: 'HelveticaNeueW23forSKY'),
                                  children: <TextSpan>[
                                    TextSpan(text: _totalCost.toString()),
                                    TextSpan(text: '  '),
                                    TextSpan(
                                      text: AppLocalizations.of(context).sr,
                                      style: TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          fontFamily: 'HelveticaNeueW23forSKY'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),






                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 30,
                                  width: _width * 0.26,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.00),
                                      ),
                                      color: cAccentColor),
                                  child: Text(
                                    _appState.currentLang=="ar"?"سعر التوصيل":"Delivery price",
                                    style: TextStyle(
                                        color: cWhite,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: cBlack,
                                      fontSize: 16,
                                      fontFamily: 'HelveticaNeueW23forSKY'),
                                  children: <TextSpan>[
                                    TextSpan(text: _appState.currentTawsil.toString()),
                                    TextSpan(text: '  '),
                                    TextSpan(
                                      text: AppLocalizations.of(context).sr,
                                      style: TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          fontFamily: 'HelveticaNeueW23forSKY'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),


                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 30,
                                  width: _width * 0.26,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.00),
                                      ),
                                      color: cAccentColor),
                                  child: Text(
                                    AppLocalizations.of(context).total,
                                    style: TextStyle(
                                        color: cWhite,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: cBlack,
                                      fontSize: 16,
                                      fontFamily: 'HelveticaNeueW23forSKY'),
                                  children: <TextSpan>[
                                    TextSpan(text: (_totalCost+_appState.currentTawsil).toString()),
                                    TextSpan(text: '  '),
                                    TextSpan(
                                      text: AppLocalizations.of(context).sr,
                                      style: TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          fontFamily: 'HelveticaNeueW23forSKY'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),


                        GestureDetector(
                          onTap: () async {
                            if (_checkValidation(context, phone:
                             _userPhone, address: _locationState.address)) {
_paymentState.setUserPhone(_userPhone);
Navigator.pushNamed(context,  '/payment_screen');
                           
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: cPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: (Radius.circular(15.0)),
                                      bottomRight: (Radius.circular(15.0)))),
                              height: 45,
                              width: _width,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).confirmOrder,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: cWhite),
                                ),
                              )),
                        )
                      ],
                    ))
              ],
            );
           
           }
           else{
           return  NoData(
             message: AppLocalizations.of(context).noResultIntoCart,
           );
           }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
              child: SpinKitSquareCircle(color: cPrimaryColor, size: 25));
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: cPrimaryColor,
      centerTitle: true,
      title: Text(AppLocalizations.of(context).cart,
          style: Theme.of(context).textTheme.display1),
    );
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
  _paymentState = Provider.of<PaymentState>(context);
    return NetworkIndicator(
        child: PageContainer(
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
    ));
  }
}
