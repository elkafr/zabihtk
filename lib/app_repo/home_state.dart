import 'package:flutter/material.dart';
import 'package:zabihtk/models/category.dart';
import 'package:zabihtk/models/city.dart';
import 'package:zabihtk/services/access_api.dart';
import 'package:zabihtk/utils/utils.dart';
import 'package:zabihtk/app_repo/app_state.dart';

class HomeState extends ChangeNotifier{
  Services _services = Services();
    List<Category> _categoriesList;
    String _currentLang;


  void setCategoriesList(List<Category> categoriesList) {
    _categoriesList = categoriesList;
    notifyListeners();
  } 

  List<Category> get categoriesList => _categoriesList;


  Category  _lastSelectedCategory ;

  void setLastSelectedCategory(Category category){
        _lastSelectedCategory = category;
    notifyListeners();
  } 

  Category  get lastSelectedCategory => _lastSelectedCategory;

  void updateChangesOnCategoriesList(int index ){ 
    if(lastSelectedCategory != null){
  _lastSelectedCategory.isSelected = false;
    }
  _categoriesList[index].isSelected = true;
  _lastSelectedCategory = _categoriesList[index];
    notifyListeners();
  }


    Future<List<City>> getCityList(
        {@required bool enableCountry, String countryId}) async {
      var response;
      if (enableCountry) {
        response = await _services.get(Utils.CITIES_URL +
            "?api_lang=ar" +
            "&country_id=$countryId");
      } else {
        response = await _services.get(Utils.CITIES_URL);
      }

      List cityList = List<City>();
      if (response['response'] == '1') {
        Iterable iterable = response['city'];
        cityList = iterable.map((model) => City.fromJson(model)).toList();
      }
      return cityList;
    }


  //  Future<List<Sacrifice>> _sacrificesList;

  // void setSacrificesList(Future<List<Sacrifice>> sacrificesList) {
  //   _sacrificesList = sacrificesList;
  //   // notifyListeners();
  // } 

  // Future<List<Sacrifice>> get sacrificesList => _sacrificesList;
}