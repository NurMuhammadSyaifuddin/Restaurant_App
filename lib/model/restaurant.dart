import 'dart:convert';

import '../utils/utils.dart';

class Restaurant {
  late String id;
  late String name;
  late String? description;
  late String pictureId;
  late String city;
  late num rating;

  Restaurant({required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating});

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      Restaurant(
          id: json['id'],
          name: json['name'],
          description: json['description'],
          pictureId: json['pictureId'],
          city: json['city'],
          rating: json['rating'],);

  String getSmallResolutionPicture() => smallResolutionUrl + pictureId;

  String getMediumResolutionPicture() => mediumResolutionUrl + pictureId;

  String getLargeResolutionPicture() => largeResolutionUrl + pictureId;

  Map<String, dynamic> toMap() => {
    'id' : id,
    'name': name,
    'pictureId': pictureId,
    'city': city,
    'rating': rating
  };

  Restaurant.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    pictureId = map['pictureId'];
    city = map['city'];
    rating = map['rating'];
  }

}
