import 'package:flutter/cupertino.dart';
import 'package:submission_3/model/customer_review.dart';
import 'package:submission_3/model/detail_restaurant_response.dart';
import 'package:submission_3/model/restaurant.dart';
import 'package:submission_3/model/restaurant_response.dart';
import 'package:submission_3/model/search_response.dart';
import 'package:submission_3/services/restaurant_service.dart';

enum ResultState { loading, noData, hashData, error }

class RestaurantProvider extends ChangeNotifier {
  final RestaurantService service;

  RestaurantProvider({required this.service});

  RestaurantResponse? _restaurants;
  late DetailRestaurantResponse _detailRestaurant;
  SearchRestaurantResponse? _searchRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantResponse get restaurants =>
      _restaurants ??
      RestaurantResponse(
          error: false, message: '', count: 0, restaurants: <Restaurant>[]);

  SearchRestaurantResponse get searchRestaurant =>
      _searchRestaurant ??
      SearchRestaurantResponse(
          error: false, founded: 0, restaurants: <Restaurant>[]);

  DetailRestaurantResponse get restaurant => _detailRestaurant;

  ResultState get state => _state;

  Future _fetchAllRestaurant({String query = ''}) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      if (query.isEmpty || query == '') {
        final response = await service.getRestaurants();
        if (response.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'No data';
        }
        _state = ResultState.hashData;
        notifyListeners();
        return _restaurants = response;
      }
      final response = await service.getDataSearch(query);

      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No data';
      }
      _state = ResultState.hashData;
      notifyListeners();
      return _searchRestaurant = response;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Oops, your connection is lost. Please check your internet and reload the application';
    }
  }

  Future _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await service.getDetailRestaurant(id);

      if (response.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data not found';
      }
      _state = ResultState.hashData;
      notifyListeners();
      return _detailRestaurant = response;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Oops, your connection is lost. Please check your internet and reload the application';
    }
  }

  Future addReview(CustomerReview review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await service.addReview(review);
      if (response.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Failed to post review';
      }
      _state = ResultState.hashData;
      notifyListeners();
      _fetchDetailRestaurant(review.id!);
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Review failed to add, check your internet and try again.';
    }
  }

  RestaurantProvider getRestaurants(String query) {
    _fetchAllRestaurant(query: query);
    return this;
  }

  RestaurantProvider getDetailRestaurant(String id) {
    _fetchDetailRestaurant(id);
    return this;
  }
}
