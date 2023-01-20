import 'dart:convert';
import 'dart:math';

import 'package:submission_3/utils/utils.dart';

import '../model/customer_review.dart';
import '../model/customer_review_response.dart';
import '../model/detail_restaurant_response.dart';
import '../model/restaurant.dart';
import '../model/restaurant_response.dart';
import 'package:http/http.dart' as http;

import '../model/search_response.dart';

class RestaurantService {
  Future<RestaurantResponse> getRestaurants() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}list'));
      if (response.statusCode == 200) {
        return RestaurantResponse.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to get data');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}detail/$id'));
      if (response.statusCode == 200) {
        return DetailRestaurantResponse.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to load data');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<SearchRestaurantResponse> getDataSearch(String query) async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}search?q=$query'));
      if (response.statusCode == 200) {
        return SearchRestaurantResponse.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to get search data');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CustomerReviewResponse> addReview(CustomerReview review) async {
    var reviewData = jsonEncode(review.toJson());

    try {
      final response = await http.post(Uri.parse('${baseUrl}review'),
          body: reviewData, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 201) {
        return CustomerReviewResponse.fromJson(json.decode(response.body));
      }

      throw Exception('Failed to add review data');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Restaurant> getRandomRestaurant() async {
    final response = await http.get(Uri.parse('${baseUrl}list'));
    if (response.statusCode == 200){
      final random = Random();

      List<Restaurant> restaurants = RestaurantResponse.fromJson(json.decode(response.body)).restaurants;
      Restaurant restaurant = restaurants[random.nextInt(restaurants.length)];
      return restaurant;
    }

    throw Exception('Failed load restaurants');
  }

}
