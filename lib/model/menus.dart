import 'drink.dart';
import 'food.dart';

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
      foods: List<Food>.from(json['foods'].map((item) => Food.fromJson(item))),
      drinks:
          List<Drink>.from(json['drinks'].map((item) => Drink.fromJson(item))));
}
