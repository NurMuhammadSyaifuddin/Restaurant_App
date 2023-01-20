import 'package:submission_3/model/category.dart';
import 'package:submission_3/model/menus.dart';
import 'package:submission_3/utils/utils.dart';

import 'customer_review.dart';

class DetailRestaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final List<Category>? categories;
  final Menus? menus;
  final List<CustomerReview>? customerReviews;

  DetailRestaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.categories,
      required this.menus,
      required this.customerReviews});

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) =>
      DetailRestaurant(
          id: json['id'],
          name: json['name'],
          description: json['description'],
          pictureId: json['pictureId'],
          city: json['city'],
          rating: json['rating'],
          categories: List<Category>.from(
              json['categories'].map((item) => Category.fromJson(item))),
          menus: json['menus'] == null ? null : Menus.fromJson(json['menus']),
          customerReviews: List<CustomerReview>.from(
              (json['customerReviews'] as List)
                  .map((item) => CustomerReview.fromJson(item))
                  .where((review) => review.name.isNotEmpty)));

  String getSmallResolutionPicture() => smallResolutionUrl + pictureId;

  String getMediumResolutionPicture() => mediumResolutionUrl + pictureId;

  String getLargeResolutionPicture() => largeResolutionUrl + pictureId;
}
