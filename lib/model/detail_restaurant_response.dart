import 'package:submission_3/model/detail_restaurant.dart';

class DetailRestaurantResponse {
  final bool error;
  final String message;
  final DetailRestaurant restaurant;

  DetailRestaurantResponse(
      {required this.error, required this.message, required this.restaurant});

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      DetailRestaurantResponse(
          error: json['error'],
          message: json['message'],
          restaurant: DetailRestaurant.fromJson(json['restaurant']));
}
