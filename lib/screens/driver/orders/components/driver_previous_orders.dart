import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/components/no_data/no_data.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/models/order.dart';
import 'package:zabihtk/screens/driver/orders/components/driver_order_item.dart';
import 'package:zabihtk/services/access_api.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/utils/utils.dart';
import 'package:provider/provider.dart';

class DriverPreviousOrders extends StatefulWidget {
  @override
  _DriverPreviousOrdersState createState() => _DriverPreviousOrdersState();
}

class _DriverPreviousOrdersState extends State<DriverPreviousOrders> {
   bool _initialRun = true;
  AppState _appState;
  Services _services = Services();
  Future<List<Order>> _orderList;

    Future<List<Order>> _getOrderList() async {
    Map<String, dynamic> results = await _services.get(
        '${Utils.DRIVER_ORDERS_URL}lang=${_appState.currentLang}&user_id=${_appState.currentUser.userId}&page=1&done=0');
    List orderList = List<Order>();
    if (results['response'] == '1') {
      Iterable iterable = results['result'];
      orderList = iterable.map((model) => Order.fromJson(model)).toList();
    } else {
      print('error');
    }
    return orderList;
  }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _orderList = _getOrderList();
      _initialRun = false;
    }
  }

   @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<Order>>(
      future: _orderList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
                  return
                   
                      Container(
                       height: height - 40 ,
                        width: width,
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DriverOrderItem(
                                
                                order: snapshot.data[index],
                                currentOrder: false,
                              );
                              
                            }),
                      );
                  
               
          } else {
            return NoData(
              message: AppLocalizations.of(context).noResults,
            );
          }
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }

        return Center(
            child: SpinKitThreeBounce(
          color: cPrimaryColor,
          size: 40,
        ));
      },
    );
  }
  }
