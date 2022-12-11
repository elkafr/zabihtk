import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/app_repo/app_state.dart';
import 'package:zabihtk/app_repo/home_state.dart';
import 'package:zabihtk/components/connectivity/network_indicator.dart';
import 'package:zabihtk/components/no_data/no_data.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/models/category.dart';
import 'package:zabihtk/models/sacrifice.dart';
import 'package:zabihtk/screens/home/components/sacrifice_item.dart';
import 'package:zabihtk/screens/home/components/slider_images.dart';
import 'package:zabihtk/services/access_api.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zabihtk/app_repo/driver_navigation_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _height = 0, _width = 0;
  Services _services = Services();
  AppState _appState;
  HomeState _homeState;
  bool _initialRun = true;
  Future<List<Category>> _categoriesList;
  Future<List<Sacrifice>> _sacrificesList;
  DriverNavigationState _driverNavigationState;

  Future<List<Category>> _getCategories() async {



    Map<String, dynamic> results =
        await _services.get(Utils.CATEGORIES_URL + _appState.currentLang);
    List<Category> categoryList = List<Category>();
    if (results['response'] == '1') {
      Iterable iterable = results['city'];
      categoryList = iterable.map((model) => Category.fromJson(model)).toList();
      if(categoryList.length >1){
      _homeState.setCategoriesList(categoryList);
      }
       _sacrificesList = _getSacrificesOFCategory('1');
    } else {
      print('error');
    }
    return categoryList;
  }
     
  Future<List<Sacrifice>> _getSacrificesOFCategory(String categoryId) async {
    Map<String, dynamic> results =
        await _services.get(Utils.SHOW_CATEGORY_URL +'lang=${_appState.currentLang}&page=1&city_id=${_appState.currentCity.cityId}&cat_id=${categoryId.toString()}');
    List<Sacrifice> sacrificeList = List<Sacrifice>();
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      sacrificeList = iterable.map((model) => Sacrifice.fromJson(model)).toList();
    } else {
      print('error');
    }
    return sacrificeList;
  }

    Future<List<Sacrifice>> _getSearchResults(String categoryId ,String title) async {
    Map<String, dynamic> results =
        await _services.get(Utils.SHOW_SEARCH_RESULT_URL +'lang=${_appState.currentLang}&title=$title&cat_id=${categoryId.toString()}');
    List<Sacrifice> sacrificeList = List<Sacrifice>();
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      sacrificeList = iterable.map((model) => Sacrifice.fromJson(model)).toList();
    } else {
      print('error');
    }
    return sacrificeList;
  }

  _launchWhatsApp() async {
   String phoneNumber = '+966505509222';
  var whatsappUrl = "whatsapp://send?phone=$phoneNumber";
  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    throw 'Could not launch $whatsappUrl';
  }
}

  @override
  void didChangeDependencies() {
     super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _homeState = Provider.of<HomeState>(context);
      _categoriesList = _getCategories();
   
      _initialRun = false;
    }

   
  }


  Widget _buildBodyItem() {
print(_appState.currentCity.cityName);

    return ListView(
      children: <Widget>[
        Container(
          color: cAccentColor,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            // Image.asset('assets/images/delivery.png'),
            // Padding(padding: EdgeInsets.all(5)),
             Text(_appState.currentLang=='ar'?"أنت إختار والباقي علينا":"You choose and the rest is upon us",style: TextStyle(fontSize: 16,color: cWhite),)
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(5)),
        SliderImages(),
        Padding(padding: EdgeInsets.all(7)),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            child: Consumer<HomeState>(builder: (context, homeState, child) {
              return FutureBuilder<List<Category>>(
                future: _categoriesList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return
                        ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    homeState.updateChangesOnCategoriesList(index);
                                    _sacrificesList = _getSacrificesOFCategory(snapshot.data[index].mtgerCatId);
                                    setState(() {

                                    });
                                  },
                                  child:  Container(
                                    width: _width * 0.24,
                                      margin: EdgeInsets.only(left: 5),
                                    decoration: homeState.categoriesList[index].isSelected ?BoxDecoration(
                                      border: Border.all(color: Color(0xffC7C7C7)),
                                      borderRadius: BorderRadius.circular(20),
                                      color:cAccentColor,
                                    ):BoxDecoration(
                                      border: Border.all(color: Color(0xffC7C7C7)),
                                      borderRadius: BorderRadius.circular(20),
                                      color:cWhite,
                                    ),

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(

                                          margin: EdgeInsets.only(top: 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[

                                              Image.network(homeState
                                                  .categoriesList[index]
                                                  .mtgerCatPhoto,
                                                height: 24,
                                                width: 26,),
                                              Padding(padding: EdgeInsets.all(2)),
                                              Text(
                                                homeState.categoriesList[index]
                                                    .mtgerCatName,
                                                style: homeState.categoriesList[index].isSelected ?TextStyle(
                                                    color: Color(0xffffffff), fontSize: 16):TextStyle(
                                                    color: Color(0xffC7C7C7), fontSize: 16),
                                              ),

                                            ],
                                          ),

                                        ),

                                      ],
                                    ),
                                  ));
                            });
                    }
                    else {
                      return NoData(
                          message: AppLocalizations.of(context).noResults
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return Center(
                      child:
                      SpinKitSquareCircle(color: cPrimaryColor, size: 25));
                },
              );
            })),

        Container(
              margin: EdgeInsets.symmetric( horizontal: 5),
              height: _height - 330,
              child:  FutureBuilder<List<Sacrifice>>(
                  future: _sacrificesList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return GridView.builder(
                            physics:  ClampingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.97,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return SacrificesItem(
                              sacrifice: snapshot.data[index],
                              );
                            });
                      } else {
                        return NoData(
                          message: AppLocalizations.of(context).noResults
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                        child: SpinKitThreeBounce(
                      color: cPrimaryColor,
                      size: 40,
                    ));
                  })
               ),

      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      backgroundColor: cPrimaryColor,
      centerTitle: true,
      title: Container(
          height: 40,
          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5,right: 10),

          decoration: BoxDecoration(
              color: cWhite, borderRadius: BorderRadius.circular(20.0)),
          child: TextFormField(
              cursorColor: cHintColor,
              maxLines: 1,
              onChanged: (text) {
                 _sacrificesList =   _getSearchResults("",text);
            setState(() {
             
            });
              },
              style: TextStyle(
                  color: cBlack, fontSize: 15, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: cPrimaryColor),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 3.0),
                prefixIcon: Image.asset(
                  'assets/images/search.png',
                  color: cHintColor,
                ),
                hintText: AppLocalizations.of(context).search,
                errorStyle: TextStyle(fontSize: 12.0),
                hintStyle: TextStyle(

                    color: cHintColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ))),

    );

    _height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return  NetworkIndicator(
        child: Scaffold(
      appBar: appBar,
      body: _buildBodyItem()
    ));
  }
}
