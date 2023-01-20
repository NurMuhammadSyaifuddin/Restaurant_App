import 'package:flutter/foundation.dart';
import 'package:submission_3/model/restaurant.dart';
import 'package:submission_3/utils/db_helper.dart';

enum ResultStateFavorite {
  loading,
  noData,
  hasData,
  error
}

enum FavoriteState {
  isFavorite,
  isNotFavorite
}

class FavoriteRestaurantProvider extends ChangeNotifier {
  late DBHelper _dbHelper;
  late ResultStateFavorite _state;
  late String _message;
  late FavoriteState _favoriteState;

  late List<Restaurant> _result;

  FavoriteRestaurantProvider() {
    _dbHelper = DBHelper();
    _getAllFavoriteRestaurant();
  }

  ResultStateFavorite get state => _state;
  FavoriteState get favoriteState => _favoriteState;

  String get message => _message;

  List<Restaurant> get result => _result;

  Future _getAllFavoriteRestaurant() async {
    try {
      _state = ResultStateFavorite.loading;
      notifyListeners();
      final response = await _dbHelper.getFavoriteRestaurant();
      if (response.isEmpty) {
        _state = ResultStateFavorite.noData;
        notifyListeners();
        return _message = 'Data not found';
      }
      _state = ResultStateFavorite.hasData;
      notifyListeners();
      return _result = response;
    } catch (e) {
      _state = ResultStateFavorite.error;
      notifyListeners();
      return _message =
          'Oops, your connection is lost. Please check your internet and reload the application';
    }
  }

  Future<void> addFavoriteRestaurant(Restaurant restaurant) async {
    await _dbHelper.insertFavoriteRestaurant(restaurant);
  }

  void deleteFavoriteRestaurant(Restaurant restaurant) async {
    await _dbHelper.deleteRestaurantFromFavorite(restaurant.id);
  }

  Future<bool> getFavoriteRestaurantById(String id) async {
    final result = await _dbHelper.checkFavoriteStatus(id);
    if (result){
      _favoriteState = FavoriteState.isFavorite;
    }else {
      _favoriteState = FavoriteState.isNotFavorite;
    }
    return result;
  }

}
