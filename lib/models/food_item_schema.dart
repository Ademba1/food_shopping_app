import 'package:isar/isar.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_item_schema.g.dart';

@Collection()
class FoodItem {
  Id id = Isar.autoIncrement;

  late int itemId;
  late String title;
  late String imageUrl;
  late String restaurantChain;
  late double servings;

  FoodItem();

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem()
      ..itemId = json['id']
      ..title = json['title']
      ..imageUrl = json['image']
      ..restaurantChain = json['restaurantChain']
      ..servings = json['servings']['number'] != null ? json['servings']['number'].toDouble() : 0.0;
  }
}
